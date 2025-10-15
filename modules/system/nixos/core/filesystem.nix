{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./filesystem.nix {
  config = {
    environment.systemPackages = with pkgs; [
      # exfat support
      exfat
      exfatprogs
    ];
  };
}
