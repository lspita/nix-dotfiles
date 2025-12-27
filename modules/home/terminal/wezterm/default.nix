{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./. {
  config =
    { selfPath, ... }:
    {
      programs.wezterm.enable = true;
      xdg.configFile."wezterm/wezterm.lua".source = dotfiles.dotSymlink inputs "${selfPath}/wezterm.lua";
    };
}
