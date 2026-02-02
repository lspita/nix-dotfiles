{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./chrome.nix {
  config = {
    home.packages = with pkgs; [ google-chrome ];
  };
}
