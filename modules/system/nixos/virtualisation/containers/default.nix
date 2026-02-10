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
      // (lib.attrsets.optionalAttrs
        ((!isNull hostInfo.graphics) && (builtins.hasAttr hostInfo.graphics self))
        {
          ${hostInfo.graphics}.enable = !hostInfo.wsl;
        }
      )
    );
}
