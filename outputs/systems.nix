{
  nixpkgs,
  nix-darwin,
  home-manager,
  haumea,
  flakeRoot,
  ...
}@flakeInputs:
let
  flakePath = path: "${flakeRoot}/${path}";
  hostsDir = flakePath "hosts";
  lib = nixpkgs.lib;
  createSystem = {
    linux = nixpkgs.lib.nixosSystem;
    darwin = nix-darwin.lib.darwinSystem;
  };
  configurationsSet = {
    linux = "nixosConfigurations";
    darwin = "darwinConfigurations";
  };
  homeModulesSet = {
    linux = "nixosModules";
    darwin = "darwinModules";
  };
  mkSystems =
    systems:
    builtins.foldl' (
      result:
      {
        hostname,
        hostInfo,
      }:
      let
        hostPath = path: "${hostsDir}/${hostname}/${path}";

        vars =
          let
            baseVars = import (flakePath "vars.nix");
            hostVarPath = hostPath "vars.nix";
          in
          baseVars // (if builtins.pathExists hostVarPath then (import hostVarPath) else { });

        baseInputs = {
          inherit
            lib
            vars
            flakeInputs
            flakePath
            ;
        };

        pkgs = import nixpkgs {
          inherit (hostInfo) system;
          config = {
            allowUnfree = vars.nix.pkgs.allowUnfree;
            allowUnfreePredicate = (_: vars.nixpkgs.allowUnfree);
          };
          overlays = builtins.attrValues (
            haumea.lib.load {
              src = flakePath "overlays";
              inputs = baseInputs;
            }
          );
        };

        inputs = baseInputs // {
          inherit pkgs systemType;
        };

        systemType =
          with pkgs.stdenv;
          if isLinux then
            "linux"
          else if isDarwin then
            "darwin"
          else
            throw "Unsupported system type";

        customLib = haumea.lib.load {
          inherit inputs;
          src = flakePath "lib";
        };

        specialArgs = builtins.removeAttrs inputs [
          "lib"
          "pkgs"
        ];
      in
      result
      // {
        ${configurationsSet.${systemType}}.${hostname} = createSystem.${systemType} {
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
            }
            # system config
            (flakePath "modules/system")
            (hostPath "configuration.nix")
            # home manager
            home-manager.${homeModulesSet.${systemType}}.home-manager
            {
              home-manager = {
                useUserPackages = mkDefault true;
                useGlobalPkgs = mkDefault true;
                backupFileExtension = mkDefault vars.backupFileExtension;
                users.${vars.user.username} = {
                  imports = [
                    (flakePath "modules/home")
                    (hostPath "home.nix")
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
