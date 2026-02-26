{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./usbutils.nix {
  config = {
    home.packages = with pkgs; [ usbutils ];
  };
}
