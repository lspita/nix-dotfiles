{ nixpkgs, flake-utils, ... }:
flake-utils.lib.eachDefaultSystem (
  system:
  let
    pkgs = import nixpkgs {
      inherit system;
    };
  in
  {
    devShell = pkgs.mkShell {
      buildInputs = with pkgs; [
        nixd
        nil
        nixfmt
        lua-language-server
        git
        markdown-oxide
      ];
    };
  }
)
