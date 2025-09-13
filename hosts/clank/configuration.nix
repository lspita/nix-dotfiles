{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./system/keyboard-remap.nix
    ./system/gnome/touchpad-resize.nix
  ];

  custom.modules.nixos = {
    core.enableDefaults = true;
    login.gdm.enable = true;
    desktop.gnome.enable = true;
  };
}
