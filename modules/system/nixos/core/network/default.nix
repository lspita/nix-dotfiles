{ lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    lib.mkMerge [
      (setDefaultSubconfig {
        networkmanager.enable = true;
        iwd = {
          enable = true;
          enableNMWifiBackend = true;
        };
      })
      {
        hardware.wirelessRegulatoryDatabase = true;
      }
    ];
}
