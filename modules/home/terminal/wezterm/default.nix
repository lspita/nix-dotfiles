{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./. {
  config =
    { path, ... }:
    {
      programs.wezterm.enable = true;
      xdg.configFile."wezterm/wezterm.lua".source = dotfiles.dotSymlink config "${path}/wezterm.lua";
    };
}
