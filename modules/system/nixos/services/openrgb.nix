{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./openrgb.nix {
  options = {
    allPlugins.enable = modules.mkEnableOption true "all plugins";
  };
  config =
    { self, ... }:
    {
      services.hardware.openrgb = {
        enable = true;
        package = with pkgs; if self.allPlugins.enable then openrgb-with-all-plugins else openrgb;
      };
    };
}
