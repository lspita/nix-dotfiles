{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./gdm.nix {
  options = {
    wayland.enable = modules.mkEnableOption true "wayland support";
  };
  config =
    { self, ... }:
    {
      services.displayManager.gdm = {
        enable = true;
        wayland = self.wayland.enable;
      };
    };
}
