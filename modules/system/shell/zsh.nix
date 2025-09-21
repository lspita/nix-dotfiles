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
      programs.zsh.enable = true;
    };
}
