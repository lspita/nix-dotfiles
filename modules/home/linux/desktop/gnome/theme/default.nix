{
  config,
  lib,
  pkgs,
  ...
}:
lib.custom.mkDefaultsModule {
  inherit config;
  importPath = ./.;
  path = [
    "linux"
    "desktop"
    "gnome"
    "theme"
  ];
}
