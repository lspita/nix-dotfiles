{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkDefaultsModule config ./. {
  config =
    { setDefaultModules, ... }:
    lib.attrsets.recursiveUpdate
      (setDefaultModules {
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
      })
      {
        home.packages = with pkgs; [
          gnome-extension-manager
          dconf-editor
        ];
        dconf.settings."org/gnome/shell".disabled-extensions = [ ];
      };
}
