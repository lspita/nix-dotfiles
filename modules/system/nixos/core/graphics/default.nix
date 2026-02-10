{ lib, hostInfo, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { self, setDefaultSubconfig, ... }:
    lib.mkMerge [
      (setDefaultSubconfig (
        lib.attrsets.optionalAttrs
          ((!isNull hostInfo.graphics) && (builtins.hasAttr hostInfo.graphics self))
          {
            ${hostInfo.graphics}.enable = !hostInfo.wsl;
          }
      ))
      {
        hardware.graphics.enable = true;
      }
    ];
}
