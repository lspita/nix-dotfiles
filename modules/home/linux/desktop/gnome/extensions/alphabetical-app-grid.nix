{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./alphabetical-app-grid.nix {
  config = gnome.mkExtensionConfig {
    package = pkgs.gnomeExtensions.alphabetical-app-grid;
  };
}
