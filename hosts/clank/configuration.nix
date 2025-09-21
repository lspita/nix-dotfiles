{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./system/keyboard-remap.nix
    ./system/gnome/touchpad-resize.nix
  ];

  custom.modules = {
    nixos = {
      core.enableDefaults = true;
      login.gdm.enable = true;
      desktop.gnome = {
        enable = true;
        excludePackages = with pkgs; [ gnome-console ]; # use kitty instead
      };
      virtualisation.containers = {
        enable = true;
        autoPrune.enable = true;
        docker.enable = true;
        podman.enable = true;
      };
    };
    shell = {
      bash.enable = true;
      zsh.enable = true;
    };
  };
}
