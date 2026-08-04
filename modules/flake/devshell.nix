{
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        # dotenv
        dotenvx
        # nix
        nixd
        nil
        nixfmt
        # lua
        lua-language-server
        # markdown
        markdown-oxide
      ];

      env = {
        DOTENV_CONFIG_IGNORE = "MISSING_ENV_FILE";
      };
      shellHook = ''
        eval "$(dotenvx get --format eval-export)"
      '';
    };
  };
}
