{
  nixpkgs,
  nix-darwin,
  home-manager,
  haumea,
  flakeRoot,
  flakePath,
  ...
}@flakeInputs:
let
  hostsDir = flakePath "hosts";
  lib = nixpkgs.lib;
  mkSystems =
    systems:
    builtins.foldl' (
      result:
      { hostname, hostInfo }:
      let
        hostPath =
          path:
          let
            fullPath = "${hostsDir}/${hostname}/${path}";
          in
          with lib.filesystem;
          if pathIsDirectory fullPath then resolveDefaultNix fullPath else "${fullPath}.nix";
        vars =
          let
            baseVars = import (flakePath "vars.nix");
            hostVarPath = hostPath "vars";
          in
          baseVars // (if builtins.pathExists hostVarPath then (import hostVarPath) else { });
        baseInputs = {
          inherit
            lib
            vars
            flakeInputs
            flakeRoot
            flakePath
            ;
        };
        pkgs = import nixpkgs {
          inherit (hostInfo) system;
          config = { inherit (vars.nix) allowUnfree; };
          overlays = builtins.attrValues (
            haumea.lib.load {
              src = flakePath "overlays";
              inputs = baseInputs;
            }
          );
        };
        systemType =
          with pkgs.stdenv;
          if isLinux then
            "linux"
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
        specialArgs = builtins.removeAttrs inputs [
          "lib"
          "pkgs"
        ];
        loadModules = type: {
          imports =
            (customLib.modules.listRec (flakePath "modules/${type}"))
            ++ (
              let
                hostConfig = hostPath type;
              in
              if builtins.pathExists hostConfig then [ hostConfig ] else [ ]
            );
        };
        createSystem = customLib.utils.osValue {
          linux = nixpkgs.lib.nixosSystem;
          darwin = nix-darwin.lib.darwinSystem;
        };
        configurationsSet = customLib.utils.osValue {
          linux = "nixosConfigurations";
          darwin = "darwinConfigurations";
        };
        homeModulesSet = customLib.utils.osValue {
          linux = "nixosModules";
          darwin = "darwinModules";
        };
      in
      result
      // {
        ${configurationsSet}.${hostname} = createSystem {
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
            (loadModules "system")
            # home manager
            home-manager.${homeModulesSet}.home-manager
            {
              home-manager = {
                useUserPackages = mkDefault true;
                useGlobalPkgs = mkDefault true;
                backupFileExtension = mkDefault vars.backupFileExtension;
                users.${vars.user.username} = {
                  imports = [
                    (loadModules "home")
                  ];
                  home.stateVersion = lib.mkDefault hostInfo.stateVersion;
                };
                extraSpecialArgs = specialArgs;
              };
            }
          ];
          specialArgs = specialArgs;
        };
      }
    ) { } systems;
in
mkSystems (
  builtins.map
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
          path: _type: (_type == "directory") # each host is a directory
        ) (builtins.readDir hostsDir)
      )
    )
)
