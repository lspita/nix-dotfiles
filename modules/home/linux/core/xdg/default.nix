{ lib, hostInfo, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    let
      notWsl = !hostInfo.wsl;
    in
    setDefaultSubconfig {
      directories.enable = true;
      mimeApps = {
        enable = true;
        openAlias.enable = notWsl;
      };
      autostart.enable = notWsl;
      terminalExec.enable = notWsl;
    };
}
