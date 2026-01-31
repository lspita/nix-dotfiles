{ lib, hostInfo, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    setDefaultSubconfig (
      if hostInfo.wsl then
        { }
      else
        {
          ssh.enable = true;
        }
    );
}
