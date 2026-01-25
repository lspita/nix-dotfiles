{ lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    setDefaultSubconfig (
      platform.systemTypeValue {
        linux = {
          printing.enable = true;
          fingerprint.enable = true;
        };
        wsl = { };
        darwin = { };
      }
    );
}
