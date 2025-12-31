{ lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    setDefaultSubconfig {
      fonts.enable = true;
      environment.enable = true;
      git.enable = true;
      wget.enable = true;
      curl.enable = true;
      gpg.enable = true;
    };
}
