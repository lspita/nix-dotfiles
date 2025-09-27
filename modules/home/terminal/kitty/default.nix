{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./. {
  config = {
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
        "${kittyConfigDir}/dark-theme.auto.conf".source =
          utils.dotSymlink config "modules/home/terminal/kitty/themes/catppuccin-mocha.conf";
        "${kittyConfigDir}/light-theme.auto.conf".source =
          utils.dotSymlink config "modules/home/terminal/kitty/themes/catppuccin-latte.conf";
      };
  };
}
