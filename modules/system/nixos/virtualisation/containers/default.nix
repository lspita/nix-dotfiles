{ lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultModules, ... }:
    setDefaultModules {
      config.enable = true;
      # docker.enable = true;
      podman.enable = true;
    };
}
