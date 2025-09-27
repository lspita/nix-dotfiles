{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./light-style.nix {
  config = gnome.mkExtensionConfig {
    package = pkgs.gnomeExtensions.light-style;
  };
}
