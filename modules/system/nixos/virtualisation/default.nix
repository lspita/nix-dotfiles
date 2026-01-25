{ lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    setDefaultSubconfig (
      platform.systemTypeValue {
        linux = {
          containers.enableDefaults = true;
        };
        darwin = { };
      }
    );
}
