{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./hide-cursor.nix {
  config = gnome.mkExtensionConfig {
    package = pkgs.gnomeExtensions.hide-cursor;
  };
}
