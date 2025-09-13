{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./system/keyboard-remap.nix
  ];

  custom.modules.nixos = {
    core.enableDefaults = true;
    login = {
      enableDefaults = true;
      sddm.enable = true;
    };
    desktop.gnome.enable = true;
  };
}
