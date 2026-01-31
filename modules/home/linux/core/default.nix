{ lib, hostInfo, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    setDefaultSubconfig {
      wsl.enableDefaults = hostInfo.wsl;
      xdg.enableDefaults = true;
      unixtools.enable = true;
      util-linux.enable = true;
    };
}
