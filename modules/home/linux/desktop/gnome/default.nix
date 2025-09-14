{
  config,
  lib,
  ...
}:
lib.custom.mkDefaultsModule {
  inherit config;
  importPath = ./.;
  path = [
    "linux"
    "desktop"
    "gnome"
  ];
  mkConfig =
    { ... }:
    {
      custom.modules.linux.desktop.gnome = with lib; {
        settings.enable = mkDefault true;
        wallpaper.enable = mkDefault true;
      };
    };
}
