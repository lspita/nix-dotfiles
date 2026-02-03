{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./portal.nix {
  options = {
    packages = lib.mkOption {
      type = with lib.types; listOf package;
      default = with pkgs; [ xdg-desktop-portal ];
      description = "Portal packages to install";
    };
  };
  config =
    { self, ... }:
    let
      packages = self.packages;
    in
    {
      xdg.portal = {
        enable = true;
        configPackages = packages;
        extraPortals = packages;
      };
    };
}
