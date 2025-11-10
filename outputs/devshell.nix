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
        # nix
        nixd
        nil
        nixfmt
        # lua
        lua-language-server
        # markdown
        markdown-oxide
      ];
    };
  }
)
