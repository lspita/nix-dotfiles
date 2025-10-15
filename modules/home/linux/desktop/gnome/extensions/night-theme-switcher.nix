{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./night-theme-switcher.nix {
  config = gnome.mkExtensionConfig {
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
