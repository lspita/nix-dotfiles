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
        shortcuts.enable = true;
        virtual-keyboard.enable = true;
        plugins.enableDefaults = true;
        appearance.enableDefaults = true;
      })
      {
        programs.plasma.enable = true;
        custom.linux.core.xdg.portal.packages = with pkgs.kdePackages; [ xdg-desktop-portal-kde ];
      }
    ];
}
