{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./. {
  config =
    { path, ... }:
    {
      programs.wezterm.enable = true;
      xdg.configFile."wezterm/wezterm.lua".source = dotfiles.dotSymlink inputs "${path}/wezterm.lua";
    };
}
