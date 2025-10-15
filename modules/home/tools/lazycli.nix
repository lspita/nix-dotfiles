{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./lazycli.nix {
  config = {
    home.packages = with pkgs; [ lazycli ];
  };
}
