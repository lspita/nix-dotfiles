{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./. {
  config = {
    home.packages = with pkgs; [ nano ];
    xdg.configFile = {
      "nano/nanorc".source = ./nanorc;
    };
  };
}
