{ systemType, lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    setDefaultSubconfig {
      xdg.enable = true;
      unixtools.enable = true;
      wsl.enableDefaults = systemType == "wsl";
    };
}
