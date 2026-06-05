{ config, lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./zsh.nix {
  config = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      autocd = true;
      dotDir = "${config.xdg.configHome}/zsh";
      initContent = lib.mkAfter (shell.loadrc inputs "zsh");
    };
  };
}
