{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./plasma.nix {
  options = {
    excludePackages = lib.mkOption {
      type = with lib.types; listOf package;
      default = [ ];
      description = "List of kde packages to exclude.";
    };
  };
  config =
    { self, ... }:
    {
      # https://wiki.nixos.org/wiki/KDE
      # https://nixos.wiki/wiki/KDE
      services.desktopManager.plasma6.enable = true;
      environment = with pkgs.kdePackages; {
        systemPackages = [
          kcalc
          kcharselect
          kclock
          kcolorchooser
          kolourpaint
          ksystemlog
          isoimagewriter
          sddm-kcm
          partitionmanager
        ];
        plasma6 = { inherit (self) excludePackages; };
      };
    };
}
