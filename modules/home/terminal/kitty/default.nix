{ customLib, config, ... }:
customLib.mkModule {
  inherit config;
  path = [
    "terminal"
    "kitty"
  ];
  mkConfig =
    { ... }:
    {
      programs.kitty.enable = true;
      xdg.configFile =
        let
          kittyConfigDir = "kitty";
        in
        {
          "${kittyConfigDir}/dark-theme.auto.conf".source = config.lib.file.mkOutOfStoreSymlink (
            customLib.dotPath config "modules/home/terminal/kitty/themes/catppuccin-mocha.conf"
          );
          "${kittyConfigDir}/light-theme.auto.conf".source = config.lib.file.mkOutOfStoreSymlink (
            customLib.dotPath config "modules/home/terminal/kitty/themes/catppuccin-latte.conf"
          );
        };
    };
}
