{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    # https://github.com/oxalica/rust-overlay
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      rust-overlay,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ rust-overlay.overlays.default ];
        };
        rust-toolchain = pkgs.rust-bin.stable.latest.default;
      in
      {
        devShell = pkgs.mkShell {
            buildInputs = with pkgs; [
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
              RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
            };
            shellHook = ''
              if [ -f .env ]; then
                set -a
                source .env
                set +a
              fi
            '';
          };
      }
    );
}
