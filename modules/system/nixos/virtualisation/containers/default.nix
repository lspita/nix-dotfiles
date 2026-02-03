{ lib, hostInfo, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { self, setDefaultSubconfig, ... }:
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
      // (optionals.ifNotNull { } (
        if builtins.hasAttr hostInfo.graphics self then
          {
            ${hostInfo.graphics}.enable = !hostInfo.wsl;
          }
        else
          { }
      ) hostInfo.graphics)
    );
}
