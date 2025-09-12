{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./system/keyboard-remap.nix
  ];

  custom.modules.nixos = {
    core.enableDefaults = true;
    login.sddm.enable = true;
    desktop.plasma = {
      enable = true;
      excludePackages = with pkgs.kdePackages; [ kate ]; # use zed instead
    };
  };
}
