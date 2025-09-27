{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./auto-power-profile.nix {
  config = gnome.mkExtensionConfig {
    package = pkgs.gnomeExtensions.auto-power-profile;
    settings = {
      "" = {
        lapmode = false;
        threshold = 20;
      };
    };
  };
}
