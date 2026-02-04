{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./gnome-console.nix {
  config = {
    dconf.settings."org/gnome/Console" = {
      theme = "auto";
      font-scale = 1.1;
    };
  };
}
