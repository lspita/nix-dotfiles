{ lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultModules, ... }:
    setDefaultModules {
      xdg.enable = true;
    };
}
