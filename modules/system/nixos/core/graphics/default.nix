{ lib, hostInfo, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { self, setDefaultSubconfig, ... }:
    lib.mkMerge [
      (setDefaultSubconfig (
        optionals.ifNotNull { } (
          if builtins.hasAttr hostInfo.graphics self then
            {
              ${hostInfo.graphics}.enable = !hostInfo.wsl;
            }
          else
            { }
        ) hostInfo.graphics
      ))
      {
        hardware.graphics.enable = true;
      }
    ];
}
