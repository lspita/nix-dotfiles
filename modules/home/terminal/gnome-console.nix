{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./gnome-console.nix {
  config = {
    home.packages = with pkgs; [ gnome-console ];
    dconf.settings."org/gnome/Console" = {
      theme = "auto";
      font-scale = 1.1;
    };
  };
}
