{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./zsh.nix {
  config = {
    programs = {
      zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        initContent = lib.mkAfter (shell.loadrc inputs "zsh");
      };
    };
  };
}
