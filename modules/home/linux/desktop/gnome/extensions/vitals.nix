{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./vitals.nix {
  config = gnome.mkExtensionConfig {
    package = pkgs.gnomeExtensions.vitals;
    settings = {
      "" = {
        position-in-panel = 0; # left
        icon-style = 1; # gnome
        show-battery = true;
        show-gpu = true; # beta
        hot-sensors = [
          "_processor_usage_"
          "_memory_usage_"
          "__temperature_avg__"
        ];
      };
    };
  };
}
