{ lib, hostInfo, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    if hostInfo.wsl then
      { }
    else
      setDefaultSubconfig {
        printing.enable = true;
        fingerprint.enable = true;
      };
}
