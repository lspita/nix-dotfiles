{ lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultModules, ... }:
    setDefaultModules {
      fonts.enable = true;
      environment.enable = true;
      git.enable = true;
      wget.enable = true;
      curl.enable = true;
    };
}
