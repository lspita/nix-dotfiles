{ config, lib, ... }@inputs:
with lib.custom;
modules.mkHostModule inputs ./. {
  enable = config.programs.plasma.enable;
  config =
    { setDefaultSubconfig, ... }:
    setDefaultSubconfig {
      touchpad.enable = true;
    };
}
