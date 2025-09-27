{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./user-themes.nix {
  config = gnome.mkExtensionConfig {
    package = pkgs.gnomeExtensions.user-themes;
  };
}
