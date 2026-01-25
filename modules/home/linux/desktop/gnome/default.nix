{ lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    platform.systemTypeValue {
      linux =
        lib.attrsets.recursiveUpdate
          (setDefaultSubconfig {
            font.enable = true;
            settings.enable = true;
            wallpaper.enable = true;
            appsLayout.enable = true;
            shortcuts.enable = true;
            nautilus.enable = true;
            accessibility.enable = true;
            extensions.enableDefaults = true;
            themes.enableDefaults = true;
          })
          {
            programs.gnome-shell.enable = true;
          };
      wsl = { };
      darwin = { };
    };
}
