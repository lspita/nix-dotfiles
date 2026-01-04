{ lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    setDefaultSubconfig (
      utils.systemValue {
        linux = {
          printing.enable = true;
          fingerprint.enable = true;
        };
        wsl = { };
        darwin = { };
      }
    );
}
