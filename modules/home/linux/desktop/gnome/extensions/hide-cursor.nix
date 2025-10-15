{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./hide-cursor.nix {
  config = gnome.mkExtensionConfig {
    package = pkgs.gnomeExtensions.hide-cursor;
  };
}
