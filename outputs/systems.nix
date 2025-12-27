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
  hostsDirRel = "hosts";
  hostsDir = flakePath hostsDirRel;
  mkSystems =
    systems:
    builtins.foldl' (
      result:
      { hostname, hostInfo }:
      let
        hostDirRel = "${hostsDirRel}/${hostname}";
        hostDir = "${hostsDir}/${hostname}";
        hostPath =
          filePath:
          let
            fullPath = "${hostDir}/${filePath}";
          in
          with lib.filesystem;
          if pathIsDirectory fullPath then fullPath else "${fullPath}.nix";
        vars =
          let
            baseVars = import (flakePath "vars.nix");
            hostVarPath = hostPath "vars";
            hostVars = if builtins.pathExists hostVarPath then (import hostVarPath) else { };
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
            if vars.linux.wsl then "wsl" else "linux"
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
            (customLib.utils.listRec (flakePath "modules/${type}"))
            ++ (
              let
                hostModulesPath = hostPath "modules/${type}";
              in
              if builtins.pathExists hostModulesPath then customLib.utils.listRec hostModulesPath else [ ]
            )
            ++ (
              let
                hostConfig = hostPath type;
              in
              if builtins.pathExists hostConfig then [ hostConfig ] else [ ]
            );
        };
        createSystem = customLib.utils.systemValue {
          linux = nixpkgs.lib.nixosSystem;
          darwin = nix-darwin.lib.darwinSystem;
        };
        configurationsSet = customLib.utils.systemValue {
          linux = "nixosConfigurations";
          darwin = "darwinConfigurations";
        };
        homeModulesSet = customLib.utils.systemValue {
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
        hostInfo = import "${hostsDir}/${hostname}/info.nix";
      in
      {
        inherit hostname hostInfo;
      }
    )
    (
      builtins.attrNames (
        lib.attrsets.filterAttrs (
          dirPath: _type: (_type == "directory") # each host is a directory
        ) (builtins.readDir hostsDir)
      )
    )
)
