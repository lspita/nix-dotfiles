{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./firmware.nix {
  config = {
    hardware.enableAllFirmware = true;
  };
}
