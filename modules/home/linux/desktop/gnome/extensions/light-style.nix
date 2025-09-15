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
    "light-style"
  ];
  mkConfig =
    { ... }:
    lib.custom.gnome.mkExtensionConfig {
      package = pkgs.gnomeExtensions.light-style;
    };
}
