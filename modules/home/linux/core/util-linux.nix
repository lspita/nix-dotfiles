{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./util-linux.nix {
  config = {
    home.packages = with pkgs; [ util-linux ];
  };
}
