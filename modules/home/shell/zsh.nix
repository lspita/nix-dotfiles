{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./zsh.nix {
  config =
    { root, ... }:
    {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        initContent = shell.loadFunctions root;
      };
    };
}
