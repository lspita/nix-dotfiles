{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./. {
  config = {
    programs.wezterm.enable = true;
    xdg.configFile."wezterm/wezterm.lua".source =
      path.dotSymlink config "modules/home/terminal/wezterm/wezterm.lua";
  };
}
