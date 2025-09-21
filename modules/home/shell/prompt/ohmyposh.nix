{
  config,
  lib,
  pkgs,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "shell"
    "prompt"
    "ohmyposh"
  ];
  extraOptions = {
    theme = lib.mkOption {
      type = with lib.types; str;
      description = "oh my posh theme";
    };
  };
  mkConfig =
    { cfg }:
    {
      home.packages = with pkgs; [ blesh ];
      programs.oh-my-posh = {
        enable = true;
        useTheme = cfg.theme;
      };
    };
}
