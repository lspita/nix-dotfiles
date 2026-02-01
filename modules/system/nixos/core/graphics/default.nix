{ lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config = {
    hardware.graphics.enable = true;
  };
}
