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
    "user-themes"
  ];
  mkConfig =
    { ... }:
    lib.custom.gnome.mkExtensionConfig {
      package = pkgs.gnomeExtensions.user-themes;
    };
}
