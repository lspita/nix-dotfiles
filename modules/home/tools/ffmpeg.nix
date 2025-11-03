{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./ffmpeg.nix {
  config = {
    home.packages = with pkgs; [ ffmpeg ];
  };
}
