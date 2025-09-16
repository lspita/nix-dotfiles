{
  config,
  lib,
  pkgs,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "linux"
    "desktop"
    "gnome"
    "extensions"
    "just-perfection"
  ];
  mkConfig =
    { ... }:
    lib.custom.gnome.mkExtensionConfig {
      package = pkgs.gnomeExtensions.just-perfection;
      settings = {
        "" = {
          support-notifier-type = 0; # don't show support request anymore
          theme = false;
          world-clock = false;
          weather = false;
          window-demands-attention-focus = true;
          startup-status = 0; # desktop
        };
      };
    };
}
