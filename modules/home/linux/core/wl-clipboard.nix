{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./wl-clipboard.nix {
  config = {
    home.packages = with pkgs; [ wl-clipboard ];
  };
}
