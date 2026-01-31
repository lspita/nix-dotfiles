{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./libreoffice.nix {
  config = {
    home.packages = with pkgs; [ libreoffice-fresh ];
  };
}
