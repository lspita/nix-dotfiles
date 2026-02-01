{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./plasma.nix {
  config = {
    # https://wiki.nixos.org/wiki/KDE
    services.desktopManager.plasma6.enable = true;
    environment.systemPackages = with pkgs.kdePackages; [
      sddm-kcm
    ];
  };
}
