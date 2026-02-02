{ lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    setDefaultSubconfig {
      themes.catppuccin.enable = true;
      layout.enable = true;
      koi = {
        enable = true;
        themes = {
          colors = {
            enable = true;
            dark = "CatppuccinMochaSapphire";
            light = "CatppuccinLatteSapphire";
          };
          cursor = {
            enable = true;
            dark = "catppuccin-mocha-sapphire-cursors";
            light = "catppuccin-latte-sapphire-cursors";
          };
          gtk = {
            enable = true;
            dark = "Breeze";
            light = "Breeze";
          };
        };
      };
    };
}
