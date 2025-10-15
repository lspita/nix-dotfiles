{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./light-style.nix {
  config = gnome.mkExtensionConfig {
    package = pkgs.gnomeExtensions.light-style;
  };
}
