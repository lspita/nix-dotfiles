{
  config,
  lib,
  pkgs,
  ...
}:
lib.custom.mkDefaultsModule {
  inherit config;
  importPath = ./.;
  path = [
    "linux"
    "desktop"
    "gnome"
    "extensions"
  ];
  mkConfig =
    { ... }:
    {
      home.packages = with pkgs; [
        gnome-extension-manager
        dconf-editor
      ];
      dconf.settings."org/gnome/shell".disabled-extensions = [ ];
      custom.modules.linux.desktop.gnome.extensions = with lib; {
        just-perfection.enable = mkDefault true;
        blur-my-shell.enable = mkDefault true;
        light-style.enable = mkDefault true;
        night-theme-switcher.enable = mkDefault true;
        user-themes.enable = mkDefault true;
        vitals.enable = mkDefault true;
        open-bar.enable = mkDefault true;
        alphabetical-app-grid.enable = mkDefault true;
        auto-power-profile.enable = mkDefault true;
      };
    };
}
