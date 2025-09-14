{
  config,
  lib,
  pkgs,
  ...
}:
lib.custom.gnome.mkExtensionModule {
  inherit config;
  package = pkgs.gnomeExtensions.dash-to-dock;
  mkConfig =
    { ... }:
    {
      "".show-trash = false;
    };
}
