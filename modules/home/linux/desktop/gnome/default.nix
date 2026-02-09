{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    lib.attrsets.recursiveUpdate
      (setDefaultSubconfig {
        appearance.enableDefaults = true;
        settings.enable = true;
        shortcuts.enable = true;
        nautilus.enable = true;
        accessibility.enable = true;
        extensions.enableDefaults = true;
        apps.enableDefaults = true;
      })
      {
        programs.gnome-shell.enable = true;
        custom.linux.core.xdg.portal.packages = with pkgs; [ xdg-desktop-portal-gnome ];
      };
}
