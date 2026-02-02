{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./dynamic-workspaces.nix {
  config = plasma.mkPluginConfig {
    package = pkgs.kdePackages.dynamic-workspaces;
    name = "dynamic_workspaces";
    settings = {
      keepEmptyMiddleDesktops = true;
    };
  };
}
