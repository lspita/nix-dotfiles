{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    if vars.linux.wsl then
      { }
    else
      setDefaultSubconfig {
        printing.enable = true;
        fingerprint.enable = true;
      };
}
