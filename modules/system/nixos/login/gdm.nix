{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./gdm.nix {
  options = {
    wayland = utils.mkEnableOption true "wayland support";
  };
  config =
    { self, ... }:
    {
      services.displayManager.gdm = {
        inherit (self) wayland;
        enable = true;
      };
    };
}
