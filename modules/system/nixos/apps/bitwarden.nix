{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./bitwarden.nix {
  config = {
    environment.systemPackages = with pkgs; [ bitwarden-desktop ];
  };
}
