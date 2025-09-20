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
        font.enable = mkDefault true;
        settings.enable = mkDefault true;
        wallpaper.enable = mkDefault true;
        appsLayout.enable = mkDefault true;
        shortcuts.enable = mkDefault true;
        nautilus.enable = mkDefault true;
        extensions.enableDefaults = mkDefault true;
        theme.adw-gtk3.enable = mkDefault true;
      };
    };
}
