{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./blur-my-shell.nix {
  options = {
    applications = {
      enable = utils.mkEnableOption false "applications blur";
      blacklist = lib.mkOption {
        type = with lib.types; listOf str;
        default = [ ];
        description = "Applications blur blacklisted apps";
      };
      opaqueFocused = utils.mkEnableOption false "opaque effect for focused app";
    };
  };
  config =
    { self, ... }:
    gnome.mkExtensionConfig {
      package = pkgs.gnomeExtensions.blur-my-shell;
      settings = {
        "overview".style-components = 3; # transparent
        "panel".blur = false;
        "applications" = with self.applications; {
          inherit blacklist;
          blur = enable;
          enable-all = true;
          dynamic-opacity = opaqueFocused;
        };
      };
    };
}
