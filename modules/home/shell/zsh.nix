{ config, lib, ... }:
lib.custom.mkModule {
  inherit config;
  path = [
    "shell"
    "zsh"
  ];
  mkConfig =
    { ... }:
    {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
      };
    };
}
