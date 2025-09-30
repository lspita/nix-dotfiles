{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./just-perfection.nix {
  config = gnome.mkExtensionConfig {
    package = pkgs.gnomeExtensions.just-perfection;
    settings = {
      "" = {
        support-notifier-type = 0; # don't show support request anymore
        theme = false;
        world-clock = false;
        weather = false;
        window-demands-attention-focus = true;
        startup-status = 0; # desktop
        workspace-switcher-should-show = true;
      };
    };
  };
}
