{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    # https://github.com/oxalica/rust-overlay
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      flake-parts,
      rust-overlay,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      perSystem = { system, pkgs, ... }: {
        _module.args.pkgs = import nixpkgs {
          inherit system;
          overlays = [ rust-overlay.overlays.default ];
        };

        devShells.default =
          let
            rust-toolchain = pkgs.rust-bin.stable.latest.default;
          in
          pkgs.mkShell {
            buildInputs = with pkgs; [
              # dotenv
              dotenvx
              # nix
              nixd
              nil
              nixfmt
              # rust
              rust-toolchain
              # toml
              tombi
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
