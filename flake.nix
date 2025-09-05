{
  description = "NixOS configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };
  outputs =
    {
      nixpkgs,
      nix-darwin,
      home-manager,
      haumea,
      ...
    }@flakeInputs:
    let
      hostsDir = ./hosts;
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
            system,
          }:
          let
            hostPath = path: "${hostsDir}/${hostname}/${path}";

            vars =
              let
                baseVars = import ./vars.nix;
                hostVarPath = hostPath "vars.nix";
              in
              baseVars // (if builtins.pathExists hostVarPath then (import hostVarPath) else { });

            baseInputs = {
              inherit
                lib
                vars
                flakeInputs
                ;
            };

            pkgs = import nixpkgs {
              inherit system;
              config = {
                allowUnfree = vars.nixpkgs.allowUnfree;
                allowUnfreePredicate = (_: vars.nixpkgs.allowUnfree);
              };
              overlays = builtins.attrValues (
                haumea.lib.load {
                  src = ./overlays;
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

            customLib = haumea.lib.load {
              src = ./lib;
              inputs = baseInputs // {
                inherit pkgs;
              };
            };

            specialArgs = {
              inherit
                customLib
                vars
                flakeInputs
                ;
            };
          in
          result
          // {
            ${configurationsSet.${systemType}}.${hostname} = createSystem.${systemType} {
              inherit system pkgs;
              modules = with lib; [
                # base system config
                {
                  networking.hostName = mkDefault hostname;
                  system.stateVersion = mkDefault vars.stateVersion;
                }
                # system config
                ./modules/system
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
                        ./modules/home
                        (hostPath "home.nix")
                      ];
                      home.stateVersion = lib.mkDefault vars.stateVersion;
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
            inherit hostname;
            inherit (hostInfo) system;
          }
        )
        (
          builtins.attrNames (
            lib.attrsets.filterAttrs (
              path: _type: (_type == "directory") # each host is a directory
            ) (builtins.readDir hostsDir)
          )
        )
    );
}
