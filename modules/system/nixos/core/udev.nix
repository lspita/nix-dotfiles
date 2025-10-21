{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./udev.nix {
  config = {
    services.udev = {
      enable = true;
      packages = with pkgs; [
        platformio-core
        openocd
      ];
    };
  };
}
