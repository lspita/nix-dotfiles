{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./caffeine.nix {
  config = gnome.mkExtensionConfig {
    package = pkgs.gnomeExtensions.caffeine;
  };
}
