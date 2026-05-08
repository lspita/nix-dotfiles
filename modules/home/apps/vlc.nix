{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./vlc.nix {
  config = {
    home.packages = with pkgs; [ vlc ];
  };
}
