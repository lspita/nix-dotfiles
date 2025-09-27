{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./ohmyposh.nix {
  options = {
    theme = lib.mkOption {
      type = with lib.types; str;
      description = "oh my posh theme";
    };
  };
  config =
    { self, ... }:
    {
      home.packages = with pkgs; [ blesh ];
      programs.oh-my-posh = {
        enable = true;
        useTheme = self.theme;
      };
    };
}
