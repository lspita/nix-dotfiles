{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./platformio.nix {
  config = platform.systemTypeValue {
    linux = {
      # https://wiki.nixos.org/wiki/Platformio
      services.udev.packages = with pkgs; [
        platformio-core.udev
        openocd
      ];
    };
    darwin = { };
  };
}
