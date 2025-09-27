{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./alphabetical-app-grid.nix {
  config = gnome.mkExtensionConfig {
    package = pkgs.gnomeExtensions.alphabetical-app-grid;
  };
}
