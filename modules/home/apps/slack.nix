{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./slack.nix {
  config = {
    home.packages = with pkgs; [ slack ];
  };
}
