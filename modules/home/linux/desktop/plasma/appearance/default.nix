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
            dark = "breeze_cursors";
            light = "Breeze_Light";
          };
          gtk = {
            enable = true;
            dark = "Breeze";
            light = "Breeze";
          };
          konsole = {
            enable = true;
            dark = "catppuccin-mocha";
            light = "catppuccin-latte";
          };
        };
      };
    };
}
