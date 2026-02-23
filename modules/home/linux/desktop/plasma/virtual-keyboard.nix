{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./virtual-keyboard.nix {
  config =
    let
      package = pkgs.kdePackages.plasma-keyboard;
      desktopPath = "${package}/share/applications/org.kde.plasma.keyboard.desktop";
    in
    {
      home.packages = [ package ];
      programs.plasma.configFile.kwinrc = {
        Wayland = {
          InputMethod = {
            value = desktopPath;
            shellExpand = true; # enabling it from the gui settings puts $e
          };
          VirtualKeyboardEnabled = true;
        };
      };
    };
}
