{ config, lib, ... }@inputs:
with lib.custom;
modules.mkHostModule inputs ./. {
  enable = config.services.desktopManager.gnome.enable;
  config =
    { setDefaultSubconfig, ... }:
    setDefaultSubconfig {
      touchpad.enable = true;
    };
}
