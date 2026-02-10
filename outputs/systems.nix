{
  nixpkgs,
  nix-darwin,
  home-manager,
  haumea,
  flakeRoot,
  flakePath,
  lib,
  listDir,
  ...
}@flakeInputs:
let
  hostsRootRel = "hosts";
  hostsRoot = flakePath hostsRootRel;
  mkSystems =
    systems:
    builtins.foldl' (
      result:
      { hostname, hostInfo }:
      let
        hostDirRel = "${hostsRootRel}/${hostname}";
        hostDir = "${hostsRoot}/${hostname}";
        hostPath =
          filePath:
          let
            fullPath = "${hostDir}/${filePath}";
          in
          if lib.filesystem.pathIsDirectory fullPath then fullPath else "${fullPath}.nix";
        vars =
          let
            baseVars = import (flakePath "vars.nix");
            hostVarPath = hostPath "vars";
            hostVars = lib.attrsets.optionalAttrs (builtins.pathExists hostVarPath) (import hostVarPath);
          in
          lib.attrsets.recursiveUpdate baseVars (
            if builtins.isFunction hostVars then hostVars baseVars else hostVars
          );
        baseInputs = {
          inherit
            lib
            vars
            hostname
            hostInfo
            hostDirRel
            hostDir
            hostPath
            flakeInputs
            flakeRoot
            flakePath
            ;
        };
        pkgs = import nixpkgs {
          inherit (hostInfo) system;
          config = { inherit (vars.nix) allowUnfree; };
          overlays =
            let
              overlaysRoot = flakePath "overlays";
            in
            map (overlayPath: import "${overlaysRoot}/${overlayPath}" baseInputs) (listDir {
              dirPath = overlaysRoot;
            });
        };
        systemType =
          with pkgs.stdenv;
          if isLinux then
            if hostInfo.wsl then "wsl" else "linux"
          else if isDarwin then
            "darwin"
          else
            throw "Unsupported system type";
        inputs = baseInputs // {
          inherit pkgs systemType;
        };
        customLib = haumea.lib.load {
          inherit inputs;
          src = flakePath "lib";
        };
        specialArgs = removeAttrs inputs [
          "lib"
          "pkgs"
        ];
        loadModules = type: {
          imports =
            (customLib.files.listRec (flakePath "modules/${type}"))
            ++ (
              let
                hostModulesPath = hostPath "modules/${type}";
              in
              if builtins.pathExists hostModulesPath then customLib.files.listRec hostModulesPath else [ ]
            )
            ++ (
              let
                hostConfig = hostPath type;
              in
              if builtins.pathExists hostConfig then [ hostConfig ] else [ ]
            );
        };
        createSystem = customLib.platform.systemTypeValue {
          linux = nixpkgs.lib.nixosSystem;
          darwin = nix-darwin.lib.darwinSystem;
        };
        configurationsSet = customLib.platform.systemTypeValue {
          linux = "nixosConfigurations";
          darwin = "darwinConfigurations";
        };
        homeModulesSet = customLib.platform.systemTypeValue {
          linux = "nixosModules";
          darwin = "darwinModules";
        };
      in
      lib.attrsets.recursiveUpdate result {
        ${configurationsSet}.${hostname} =
          let
            configType = "system";
          in
          createSystem {
            inherit pkgs;
            inherit (hostInfo) system;
            lib = lib.extend (
              _: _: {
                custom = customLib;
              }
            );
            modules = with lib; [
              # base system config
              {
                networking.hostName = mkDefault hostname;
                system.stateVersion = mkDefault hostInfo.stateVersion;
                nix.nixPath = mkDefault [ "nixpkgs=${nixpkgs}" ]; # https://github.com/nix-community/nixd/blob/main/nixd/docs/configuration.md
              }
              # system config
              (hostPath "hardware")
              (loadModules configType)
              # home manager
              home-manager.${homeModulesSet}.home-manager
              {
                home-manager =
                  let
                    configType = "home";
                  in
                  {
                    useUserPackages = mkDefault true;
                    useGlobalPkgs = mkDefault true;
                    backupFileExtension = mkDefault vars.backupFileExtension;
                    users.${vars.user.username} = {
                      imports = [
                        (loadModules configType)
                      ];
                      home.stateVersion = lib.mkDefault hostInfo.stateVersion;
                    };
                    extraSpecialArgs = specialArgs // {
                      inherit configType;
                    };
                  };
              }
            ];
            specialArgs = specialArgs // {
              inherit configType;
            };
          };
      }
    ) { } systems;
in
mkSystems (
  map
    (
      hostname:
      let
        hostInfo = import "${hostsRoot}/${hostname}/info.nix";
      in
      {
        inherit hostname;
        hostInfo = {
          inherit (hostInfo) system stateVersion;
          hostname = hostInfo.hostname or hostname;
          wsl = hostInfo.wsl or false;
          graphics = hostInfo.graphics or null;
        };
      }
    )
    (
      builtins.attrNames (
        lib.attrsets.filterAttrs (
          dirPath: _type: (_type == "directory") # each host is a directory
        ) (builtins.readDir hostsRoot)
      )
    )
)
