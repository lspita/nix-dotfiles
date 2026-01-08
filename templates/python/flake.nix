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
          let
            ccLib = stdenv.cc.cc.lib;
          in
          mkShell {
            buildInputs = [
              # nix
              nixd
              nil
              nixfmt
              # python
              python3
              ccLib
            ];
            shellHook = ''
              set -a
              LD_LIBRARY_PATH=${ccLib}/lib:$LD_LIBRARY_PATH
              source .env 2> /dev/null
              set +a

              if [ ! -d .venv ]; then
                python3 -m venv .venv
              fi
              source .venv/bin/activate
            '';
          };
      }
    );
}
