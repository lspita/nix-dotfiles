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
  extraOptions = {
    applications = {
      enable = lib.custom.mkTrueEnableOption "applications blur";
      blacklist = lib.mkOption {
        type = with lib.types; listOf str;
        default = [ ];
        description = "Applications blur blacklisted apps";
      };
      opaqueFocused = lib.mkEnableOption "opaque effect for focused app";
    };
  };
  mkConfig =
    { cfg }:
    lib.custom.gnome.mkExtensionConfig {
      package = pkgs.gnomeExtensions.blur-my-shell;
      settings = {
        "overview".style-components = 3; # transparent
        "panel".blur = false;
        "applications" = with cfg.applications; {
          inherit blacklist;
          enable-all = enable;
          dynamic-opacity = opaqueFocused;
        };
      };
    };
}
