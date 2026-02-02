{
  lib,
  flakeInputs,
  pkgs,
  ...
}@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  imports = [ flakeInputs.plasma-manager.homeModules.plasma-manager ];
  config =
    { setDefaultSubconfig, ... }:
    lib.mkMerge [
      (setDefaultSubconfig {
        settings.enable = true;
        virtual-keyboard.enable = true;
        plugins.enableDefaults = true;
        appearance = {
          themes.catppuccin.enable = true;
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
      })
      {
        programs.plasma.enable = true;
        custom.linux.core.xdg.portal.packages =
          with pkgs;
          with kdePackages;
          [
            xdg-desktop-portal-kde
            xdg-desktop-portal-gtk # needed for some applications to detect theme changes (e.g. Zed)
          ];
      }
    ];
}
