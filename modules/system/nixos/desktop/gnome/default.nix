{
  lib,
  pkgs,
  vars,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./. {
  options = {
    excludePackages = lib.mkOption {
      type = with lib.types; listOf package;
      default = optionals.ifNotNull [ ] (with pkgs; [
        gnome-console
      ]) vars.linux.defaultApps.terminal;
      description = "Gnome packages to exclude";
    };
  };
  config =
    { self, setSubconfig, ... }:
    {
      services.desktopManager.gnome.enable = true;
      environment = {
        gnome.excludePackages =
          with pkgs;
          [
            gnome-contacts
            gnome-tour
            geary
            epiphany
            yelp
            gnome-maps
          ]
          ++ self.excludePackages;
        # Fix visual glitches in gtk popup windows
        # https://www.reddit.com/r/Fedora/comments/1oirfcr/comment/nlzxhyq/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
        # sessionVariables.GSK_RENDERER = "gl";
      };
    }
    // (setSubconfig {
      nautilus.enableDefaults = true;
    });
}
