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
            ];
            shellHook = ''
              set -a
              source .env 2> /dev/null
              set +a

              if [ ! -d .venv ]; then
                echo "Creating virtual environment..."
                python3 -m venv .venv
              fi
              source .venv/bin/activate
            '';
          };
      }
    );
}
