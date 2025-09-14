{ config, lib, ... }:
lib.custom.mkModule {
  inherit config;
  path = [
    "terminal"
    "wezterm"
  ];
  mkConfig =
    { ... }:
    {
      programs.wezterm.enable = true;
      xdg.configFile."wezterm/wezterm.lua".source = config.lib.file.mkOutOfStoreSymlink (
        lib.custom.dotPath config "modules/home/terminal/wezterm/wezterm.lua"
      );
    };
}
