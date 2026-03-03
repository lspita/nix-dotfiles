{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./portal.nix {
  options = {
    packages = lib.mkOption {
      type = with lib.types; listOf package;
      default = [ ];
      description = "Portal packages to install";
    };
    config = lib.mkOption {
      type = with lib.types; attrs;
      default = { };
      description = "Portal configuration";
    };
  };
  config =
    { self, ... }:
    let
      packages =
        if (lib.lists.count self.packages) == 0 then (with pkgs; [ xdg-desktop-portal ]) else self.packages;
    in
    {
      xdg.portal = {
        inherit (self) config;
        enable = true;
        configPackages = packages;
        extraPortals = packages;
        xdgOpenUsePortal = true;
      };
      home.sessionVariables.GTK_USE_PORTAL = "1";
    };
}
