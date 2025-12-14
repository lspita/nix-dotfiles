{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./app-hider.nix {
  config = gnome.mkExtensionConfig {
    package = pkgs.gnomeExtensions.app-hider;
    settings =
      let
        fullHideApps = [
          "htop.desktop"
          "org.gnome.Extensions.desktop"
        ];
      in
      {
        "" = {
          hidden-apps = fullHideApps;
          hidden-search-apps = fullHideApps;
        };
      };
  };
}
