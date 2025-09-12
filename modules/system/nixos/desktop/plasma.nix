{
  config,
  customLib,
  lib,
  pkgs,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "nixos"
    "desktop"
    "plasma"
  ];
  extraOptions = {
    excludePackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      description = "List of packages to exclude from the desktop environment.";
    };
  };
  mkConfig =
    { cfg }:
    {
      # https://nixos.wiki/wiki/KDE
      services.desktopManager.plasma6.enable = true;
      programs.partition-manager.enable = true;
      environment = with pkgs.kdePackages; {
        systemPackages = [
          kcalc
          kcharselect
          kclock
          kcolorchooser
          kolourpaint
          ksystemlog
          isoimagewriter
        ];
        plasma6 = { inherit (cfg) excludePackages; };
      };
    };
}
