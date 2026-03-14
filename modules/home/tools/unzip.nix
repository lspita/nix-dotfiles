{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./unzip.nix {
  config = {
    home.packages = with pkgs; [ unzip ];
  };
}
