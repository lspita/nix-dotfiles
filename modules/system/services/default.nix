{ systemType, lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    setDefaultSubconfig (
      if systemType == "wsl" then
        { }
      else
        {
          ssh.enable = true;
        }
    );
}
