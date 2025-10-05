{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./caffeine.nix {
  config = gnome.mkExtensionConfig {
    package = pkgs.gnomeExtensions.caffeine;
  };
}
