{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./unixtools.nix {
  config = {
    home.packages = with pkgs; utils.listPackages unixtools;
  };
}
