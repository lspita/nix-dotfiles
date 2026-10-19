{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./nicotine-plus.nix {
  config = {
    home.packages = with pkgs; [ nicotine-plus ];
  };
}
