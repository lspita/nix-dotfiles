{ config, lib, ... }:
with lib.custom;
modules.mkDefaultsModule config ./. {
  config =
    { setDefaultModules, ... }:
    lib.attrsets.recursiveUpdate
      (setDefaultModules {
        font.enable = true;
        settings.enable = true;
        wallpaper.enable = true;
        appsLayout.enable = true;
        shortcuts.enable = true;
        nautilus.enable = true;
        extensions.enableDefaults = true;
        theme.adw-gtk3.enable = true;
      })
      {
        programs.gnome-shell.enable = true;
      };
}
