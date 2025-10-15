{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./nautilus.nix {
  config = {
    dconf.settings."org/gnome/nautilus/preferences" = {
      show-create-link = true;
      show-delete-permanently = true;
    };
  };
}
