{ lib, flakeInputs, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  imports = [ flakeInputs.plasma-manager.homeModules.plasma-manager ];
  config =
    { setDefaultSubconfig, ... }:
    lib.mkMerge [
      (setDefaultSubconfig {
        settings.enable = true;
      })
      {
        programs.plasma.enable = true;
      }
    ];
}
