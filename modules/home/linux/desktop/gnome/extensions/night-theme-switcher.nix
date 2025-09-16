{
  config,
  lib,
  pkgs,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "linux"
    "desktop"
    "gnome"
    "extensions"
    "night-theme-switcher"
  ];
  mkConfig =
    { ... }:
    lib.custom.gnome.mkExtensionConfig {
      package = pkgs.gnomeExtensions.night-theme-switcher;
      name = "nightthemeswitcher";
      settings = {
        "time" = {
          nightthemeswitcher-ondemand-keybinding = [ "<Super>F5" ];
          # switch only with keybind
          manual-schedule = true;
          sunrise = 0.0;
          sunset = 0.0;
        };
      };
    };
}
