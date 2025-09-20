{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      nixpkgs,
      nix-darwin,
      home-manager,
      haumea,
      flake-utils,
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
            hostInfo,
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
              inherit (hostInfo) system;
              config = {
                allowUnfree = vars.nix.pkgs.allowUnfree;
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
                inherit pkgs systemType;
              };
            };

            specialArgs = {
              inherit
                vars
                flakeInputs
                systemType
                ;
            };
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
    // (flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          name = "nix-dotfiles default devshell";
          buildInputs = with pkgs; [
            nixd
            nil
            nixfmt
            lua-language-server
            git
            direnv
          ];

          shellHook = ''
            echo "Hello, world"
          '';
        };
      }
    ));
}
