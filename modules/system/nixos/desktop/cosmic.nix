{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./cosmic.nix {
  config = {
    services.desktopManager.cosmic = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
