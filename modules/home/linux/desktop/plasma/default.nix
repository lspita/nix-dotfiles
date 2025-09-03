{
  config,
  customLib,
  ...
}:
customLib.mkDefaultsModule {
  inherit config;
  importPath = ./.;
  path = [
    "linux"
    "desktop"
    "plasma"
  ];
  mkConfig =
    { ... }:
    {
      custom.modules.linux.desktop.plasma = {
        settings.enable = true;
        appearance = {
          catppuccin.enable = true;
          wallpapers.enable = true;
        };
      };
    };
}
