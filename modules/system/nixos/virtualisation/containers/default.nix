{ lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    setDefaultSubconfig (
      utils.systemValue {
        linux = {
          config.enable = true;
          docker.enable = true;
          podman.enable = true;
        };
        darwin = { };
      }
    );
}
