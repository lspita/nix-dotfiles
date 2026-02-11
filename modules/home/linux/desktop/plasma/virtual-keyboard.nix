{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./virtual-keyboard.nix {
  config =
    let
      package = pkgs.maliit-keyboard;
    in
    {
      home.packages = [ package ];
      programs.plasma.configFile.kwinrc = {
        Wayland = {
          InputMethod = {
            value = "${package}/share/applications/com.github.maliit.keyboard.desktop";
            shellExpand = true; # enabling it from the gui settings puts $e
          };
          VirtualKeyboardEnabled = false; # not enabled by default
        };
      };
    };
}
