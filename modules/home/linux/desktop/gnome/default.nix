{ lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    lib.attrsets.recursiveUpdate
      (setDefaultSubconfig {
        font.enable = true;
        settings.enable = true;
        wallpaper.enable = true;
        appsLayout.enable = true;
        shortcuts.enable = true;
        nautilus.enable = true;
        extensions.enableDefaults = true;
        themes.enableDefaults = true;
      })
      {
        programs.gnome-shell.enable = true;
      };
}
