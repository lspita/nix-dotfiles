{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./kdenlive.nix {
  config = {
    home.packages = with pkgs.kdePackages; [ kdenlive ];
  };
}
