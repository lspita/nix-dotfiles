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
          koi = {
            enable = true;
            themes = {
              colors = {
                enable = true;
                dark = "BreezeDark";
                light = "BreezeLight";
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
            };
          };
        };
      })
      {
        programs.plasma.enable = true;
        custom.linux.core.xdg.portal.packages = with pkgs.kdePackages; [ xdg-desktop-portal-kde ];
      }
    ];
}
