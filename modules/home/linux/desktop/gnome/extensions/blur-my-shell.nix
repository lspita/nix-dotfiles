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
    "blur-my-shell"
  ];
  mkConfig =
    { ... }:
    lib.custom.gnome.mkExtensionConfig {
      package = pkgs.gnomeExtensions.blur-my-shell;
      settings = {
        "panel".blur = false;
        "overview".style-components = 3; # transparent
      };
    };
}
