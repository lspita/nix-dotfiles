{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    lib.attrsets.recursiveUpdate
      (setDefaultSubconfig {
        just-perfection.enable = true;
        blur-my-shell.enable = true;
        light-style.enable = true;
        night-theme-switcher.enable = true;
        user-themes.enable = true;
        vitals.enable = true;
        open-bar.enable = true;
        alphabetical-app-grid.enable = true;
        auto-power-profile.enable = true;
        caffeine.enable = true;
        hide-cursor.enable = true;
        app-hider.enable = true;
      })
      {
        home.packages = with pkgs; [
          gnome-extension-manager
          dconf-editor
        ];
        dconf.settings."org/gnome/shell".disabled-extensions = [ ];
      };
}
