{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./udev.nix {
  config = {
    services.udev.enable = true;
  };
}
