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
      programs.gnome-shell.enable = true;
      custom.modules.linux.desktop.gnome = with lib; {
        settings.enable = mkDefault true;
        wallpaper.enable = mkDefault true;
        dock.enable = mkDefault true;
        shortcuts.enable = mkDefault true;
      };
    };
}
