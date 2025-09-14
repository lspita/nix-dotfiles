{ config, lib, ... }:
lib.custom.mkModule {
  inherit config;
  path = [
    "terminal"
    "kitty"
  ];
  mkConfig =
    { ... }:
    {
      programs.kitty = {
        enable = true;
        settings = {
          term = "xterm-256color"; # xterm-kitty not good for ssh
          touch_scroll_multiplier = 2.0;
        };
      };
      xdg.configFile =
        let
          kittyConfigDir = "kitty";
        in
        {
          "${kittyConfigDir}/dark-theme.auto.conf".source = config.lib.file.mkOutOfStoreSymlink (
            lib.custom.dotPath config "modules/home/terminal/kitty/themes/catppuccin-mocha.conf"
          );
          "${kittyConfigDir}/light-theme.auto.conf".source = config.lib.file.mkOutOfStoreSymlink (
            lib.custom.dotPath config "modules/home/terminal/kitty/themes/catppuccin-latte.conf"
          );
        };
    };
}
