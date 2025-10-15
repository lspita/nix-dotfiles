{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./user-themes.nix {
  config = gnome.mkExtensionConfig {
    package = pkgs.gnomeExtensions.user-themes;
  };
}
