{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShell =
          with pkgs;
          mkShell {
            buildInputs = [
              # nix
              nixd
              nil
              nixfmt
              # python
              python3
              ruff
              ty
              uv
            ];
            shellHook = ''
              if [ -f .env ]; then
                set -a
                source .env
                set +a
              fi

              uv sync --frozen
              source .venv/bin/activate
            '';
          };
      }
    );
}
