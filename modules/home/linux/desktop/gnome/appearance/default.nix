{ lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    setDefaultSubconfig {
      themes.enableDefaults = true;
      layout.enable = true;
      fonts.enable = true;
      wallpapers.enable = true;
    };
}
