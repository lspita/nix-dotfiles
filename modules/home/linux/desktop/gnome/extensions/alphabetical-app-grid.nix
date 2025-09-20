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
    "alphabetical-app-grid"
  ];
  mkConfig =
    { ... }:
    lib.custom.gnome.mkExtensionConfig {
      package = pkgs.gnomeExtensions.alphabetical-app-grid;
    };
}
