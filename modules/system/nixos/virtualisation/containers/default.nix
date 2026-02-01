{ lib, hostInfo, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    setDefaultSubconfig (
      {
        config.enable = true;
        docker.enable = true;
        podman = {
          enable = true;
          setAsContainersBackend = true;
          compose.addAsContainersProvider = true;
        };
      }
      // (optionals.ifNotNull { } {
        ${hostInfo.graphics}.enable = !hostInfo.wsl;
      } hostInfo.graphics)
    );
}
