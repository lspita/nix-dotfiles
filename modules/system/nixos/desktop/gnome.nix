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
    "gnome"
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
      services.desktopManager.gnome.enable = true;
      environment.gnome = { inherit (cfg) excludePackages; };
    };
}
