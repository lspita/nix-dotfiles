{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./curl.nix {
  config = {
    home.packages = with pkgs; [ curl ];
  };
}
