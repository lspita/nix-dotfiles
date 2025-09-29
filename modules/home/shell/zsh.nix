{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./zsh.nix {
  config = {
    programs = {
      zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        initContent = lib.mkAfter (shell.loadrc config "zsh");
      };
    };
  };
}
