{ lib, hostInfo, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    let
      notWsl = !hostInfo.wsl;
    in
    setDefaultSubconfig {
      ssh.enable = notWsl;
    };
}
