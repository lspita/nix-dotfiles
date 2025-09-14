{
  config,
  lib,
  pkgs,
  ...
}:
lib.custom.gnome.mkExtensionModule {
  inherit config;
  package = pkgs.gnomeExtensions.blur-my-shell;
  mkConfig =
    { ... }:
    {
      "panel".blur = false;
    };
}
