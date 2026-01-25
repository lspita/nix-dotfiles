{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    setDefaultSubconfig {
      wsl.enableDefaults = vars.linux.wsl;
      xdg.enableDefaults = true;
      unixtools.enable = true;
    };
}
