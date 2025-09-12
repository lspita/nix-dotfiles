{ customLib, config, ... }:
customLib.mkModule {
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
        customLib.dotPath config "modules/home/terminal/wezterm/wezterm.lua"
      );
    };
}
