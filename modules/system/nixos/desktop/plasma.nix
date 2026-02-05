{
  lib,
  pkgs,
  vars,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./plasma.nix {
  options = {
    excludePackages = lib.mkOption {
      type = with lib.types; listOf package;
      default = optionals.ifNotNull [ ] (with pkgs.kdePackages; [
        konsole
      ]) vars.linux.defaultApps.terminal;
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
          partitionmanager
          # sddm settings integration
          sddm-kcm
          # online accounts integration
          kaccounts-integration
          kaccounts-providers
        ];
        plasma6 = {
          excludePackages = self.excludePackages;
        };
      };
    };
}
