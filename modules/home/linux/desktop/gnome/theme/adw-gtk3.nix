{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./adw-gtk3.nix {
  config = {
    home.packages = with pkgs; [ adw-gtk3 ];
    dconf.settings."org/gnome/desktop/interface".gtk-theme = "adw-gtk3";
  };
}
