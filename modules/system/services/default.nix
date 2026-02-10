{ lib, hostInfo, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    setDefaultSubconfig (
      let
        notWsl = !hostInfo.wsl;
      in
      {
        ssh.enable = notWsl;
      }
    );
}
