{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./auto-power-profile.nix {
  config = gnome.mkExtensionConfig {
    package = pkgs.gnomeExtensions.auto-power-profile;
    settings = {
      "" = {
        ac = "balanced";
        bat = "balanced";
        lapmode = false;
        threshold = 20;
      };
    };
  };
}
