{
  description = "NixOS configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
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
      home-manager,
      haumea,
      ...
    }@flakeInputs:
    let
      mkSystem =
        {
          hostname,
          system ? "x86_64-linux",
        }:
        let
          hostPath = path: ./hosts/${hostname}/${path};

          vars =
            let
              baseVars = import ./vars.nix;
              hostVarPath = hostPath "vars.nix";
            in
            baseVars // (if builtins.pathExists hostVarPath then (import hostVarPath) else { });
          lib = nixpkgs.lib;
          libInputs = {
            inherit lib vars flakeInputs;
          };

          customLib = haumea.lib.load {
            src = ./lib;
            inputs = libInputs;
          };

          specialArgs = {
            inherit
              customLib
              vars
              flakeInputs
              ;
          };
        in
        lib.nixosSystem {
          inherit system;
          modules = [
            # nixpkgs settings
            {
              nixpkgs = {
                config = {
                  allowUnfree = vars.nixpkgs.allowUnfree;
                };
                overlays = builtins.attrValues (
                  haumea.lib.load {
                    src = ./overlays;
                    inputs = libInputs;
                  }
                );
              };
            }
            # host hardware config
            (hostPath "hardware-configuration.nix")
            # base system config
            {
              networking.hostName = lib.mkIf vars.overrideHostname (lib.mkForce hostname);
              system.stateVersion = vars.stateVersion;
            }
            # system config
            ./modules/system
            (hostPath "configuration.nix")
            # home manager
            home-manager.nixosModules.home-manager
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
    in
    {
      nixosConfigurations = {
        clank = mkSystem {
          hostname = "clank";
        };
      };
    };
}
