{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./cloc.nix {
  config = {
    home.packages = with pkgs; [ cloc ];
  };
}
