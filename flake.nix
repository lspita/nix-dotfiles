{
  description = "NixOS configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
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

    # bitwarden-desktop: Build desktop proxy #425477
    # https://github.com/NixOS/nixpkgs/pull/425477
    bitwarden-desktop-proxy-fix = {
      url = "github:nixos/nixpkgs/b3ce5dae9deb6af047bc1a2420bdc3a009b064cc";
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
              modules = [
                # base system config
                {
                  networking.hostName = lib.mkIf vars.overrideHostname (lib.mkForce hostname);
                  system.stateVersion = vars.stateVersion;
                }
                # system config
                ./modules/system
                (hostPath "configuration.nix")
                # home manager
                home-manager.${homeModulesSet.${systemType}}.home-manager
                {
                  home-manager = {
                    useUserPackages = true;
                    useGlobalPkgs = true;
                    users.${vars.user.username} = {
                      imports = [
                        ./modules/home
                        (hostPath "home.nix")
                      ];
                      home.stateVersion = vars.stateVersion;
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
        (hostname: {
          inherit hostname;
          system = import "${hostsDir}/${hostname}/system.nix";
        })
        (
          builtins.attrNames (
            lib.attrsets.filterAttrs (
              path: _type: (_type == "directory") # each host is a directory
            ) (builtins.readDir hostsDir)
          )
        )
    );
}
