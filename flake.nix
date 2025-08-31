{
  description = "NixOS configuration";

  inputs = {
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nixpkgs-stable = {
      url = "github:nixos/nixpkgs/nixos-25.05";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    {
      nixpkgs-unstable,
      nixpkgs-stable,
      home-manager,
      haumea,
      bitwarden-desktop-proxy-fix,
      ...
    }:
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
          mkPackages =
            pkgs:
            import pkgs {
              inherit system;
              config = {
                allowUnfree = vars.nixpkgs.allowUnfree;
              };
            };
          pkgs-unstable = mkPackages nixpkgs-unstable;
          pkgs-stable = mkPackages nixpkgs-stable;
          lib = pkgs-unstable.lib;
          customLib = haumea.lib.load {
            src = ./lib;
            inputs = {
              inherit lib vars;
            };
          };
          specialArgs = {
            inherit
              customLib
              vars
              pkgs-stable
              bitwarden-desktop-proxy-fix
              ;
          };
        in
        nixpkgs-unstable.lib.nixosSystem {
          inherit system;
          pkgs = pkgs-unstable;
          modules = [
            {
              networking.hostName = lib.mkIf vars.overrideHostname (lib.mkForce hostname);
              system.stateVersion = vars.stateVersion;
            }
            (hostPath "hardware-configuration.nix")
            ./modules/system
            (hostPath "configuration.nix")
            home-manager.nixosModules.home-manager
            {
              # home manager
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
