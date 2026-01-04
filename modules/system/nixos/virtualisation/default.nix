{ lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    setDefaultSubconfig (
      utils.systemValue {
        linux = {
          containers.enableDefaults = true;
        };
        darwin = { };
      }
    );
}
