{
  config,
  lib,
  pkgs,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "linux"
    "desktop"
    "gnome"
    "extensions"
    "auto-power-profile"
  ];
  mkConfig =
    { ... }:
    lib.custom.gnome.mkExtensionConfig {
      package = pkgs.gnomeExtensions.auto-power-profile;
      settings = {
        "" = {
          lapmode = false;
          threshold = 20;
        };
      };
    };
}
