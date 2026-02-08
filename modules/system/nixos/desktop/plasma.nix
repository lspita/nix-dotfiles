{
  config,
  lib,
  pkgs,
  vars,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./plasma.nix {
  options = {
    integrations.enable = modules.mkEnableOption true "accounts integration";
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
    lib.mkMerge [
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
          ]
          ++ (
            if config.services.displayManager.sddm.enable then
              [
                # sddm settings integration
                sddm-kcm
              ]
            else
              [ ]
          );
          plasma6 = {
            excludePackages = self.excludePackages;
          };
        };
      }
      (lib.mkIf self.integrations.enable {
        environment.systemPackages = with pkgs.kdePackages; [
          # online accounts integration
          kaccounts-integration
          kaccounts-providers
          signond
          signon-kwallet-extension
          kio-gdrive
        ];
      })
    ];
}
