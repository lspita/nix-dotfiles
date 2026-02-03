{ lib, ... }@inputs:
with lib.custom;
modules.mkHostModule inputs ./touchpad.nix {
  config = {
    programs.plasma.input.touchpads = [
      {
        # cat /proc/bus/input/devices and search name, product and vendor
        name = "SYNA3580:00 06CB:CFD2 Touchpad";
        productId = "cfd2";
        vendorId = "06cb";
        enable = true;
        disableWhileTyping = true;
        naturalScroll = true;
        scrollSpeed = 0.5;
      }
    ];
  };
}
