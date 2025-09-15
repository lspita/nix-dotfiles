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
    "vitals"
  ];
  mkConfig =
    { ... }:
    lib.custom.gnome.mkExtensionConfig {
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
