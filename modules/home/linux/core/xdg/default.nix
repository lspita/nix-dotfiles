{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    let
      notWsl = !vars.linux.wsl;
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
