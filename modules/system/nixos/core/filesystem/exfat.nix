{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./exfat.nix {
  config = {
    environment.systemPackages = with pkgs; [
      # exfat support
      exfat
      exfatprogs
    ];
  };
}
