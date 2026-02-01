{ lib, hostInfo, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    lib.mkMerge [
      (setDefaultSubconfig (
        optionals.ifNotNull { } {
          ${hostInfo.graphics}.enable = !hostInfo.wsl;
        } hostInfo.graphics
      ))
      {
        hardware.graphics.enable = true;
      }
    ];
}
