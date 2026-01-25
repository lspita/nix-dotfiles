{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    setDefaultSubconfig (
      if vars.linux.wsl then
        { }
      else
        {
          ssh.enable = true;
        }
    );
}
