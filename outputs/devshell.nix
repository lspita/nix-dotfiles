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
      name = "nix-dotfiles default devshell";
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
