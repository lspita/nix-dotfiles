{
  description = "NixOS configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nixpkgs-stable = {
      url = "github:nixos/nixpkgs/nixos-25.05";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      haumea,
      ...
    }:
    let
      lib = nixpkgs.lib;
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
            baseVars // (lib.mkIf (builtins.pathExists hostVarPath) (import hostVarPath));
          customLib = haumea.lib.load {
            src = ./lib;
            inputs = {
              inherit lib vars;
            };
          };
          specialArgs = {
            inherit customLib vars;
            pkgs-stable = import nixpkgs-stable {
              inherit system;
              config.allowUnfree = vars.nixpkgs.allowUnfree;
            };
          };
        in
        lib.nixosSystem {
          system = system;
          modules = [
            {
              nixpkgs = {
                config.allowUnfree = vars.nixpkgs.allowUnfree;
              };
            }
            (hostPath "hardware-configuration.nix")
            (import ./modules/system)
            (hostPath "configuration.nix")
            home-manager.nixosModules.home-manager
            {
              # home manager
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                users.${vars.user.username}.imports = [
                  ./modules/home
                  (hostPath "home.nix")
                ];
                extraSpecialArgs = specialArgs;
              };
            }
            (lib.mkIf vars.overrideHostname { networking.hostName = hostname; })
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
