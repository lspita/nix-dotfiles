{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    { nixpkgs, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      perSystem = { pkgs, ... }: {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # dotenv
            dotenvx
            # nix
            nixd
            nil
            nixfmt
            # java
            jdk
            gradle
          ];

          env = {
            DOTENV_CONFIG_IGNORE = "MISSING_ENV_FILE";
          };
          shellHook = ''
            eval "$(dotenvx get --format eval-export)"
          '';
        };
      };
    };
}
