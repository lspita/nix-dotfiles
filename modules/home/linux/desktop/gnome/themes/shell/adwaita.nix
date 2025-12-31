{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./adwaita.nix {
  config = {
    dconf.settings."org/gnome/desktop/wm/preferences".theme = "Adwaita";
  };
}
