{ den, ... }: {
  den.aspects.system.firmware = {
    redistributable.nixos.hardware.enableRedistributableFirmware = true;
    all = {
      nixos.hardware.enableAllFirmware = true;
      includes = [
        (den.batteries.unfree [
          "broadcom-bt-firmware"
          "b43-firmware"
          "xone-dongle-firmware"
          "facetimehd-calibration"
          "facetimehd-firmware"
        ])
      ];
    };
  };
}
