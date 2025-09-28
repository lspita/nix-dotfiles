{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./. {
  config =
    { path, ... }:
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
          "${kittyConfigDir}/dark-theme.auto.conf".source =
            dotfiles.dotSymlink config "${path}/themes/catppuccin-mocha.conf";
          "${kittyConfigDir}/light-theme.auto.conf".source =
            dotfiles.dotSymlink config "${path}/themes/catppuccin-latte.conf";
        };
    };
}
