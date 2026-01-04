{ lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    let
      defaultModules = {
        ssh.enable = true;
      };
    in
    setDefaultSubconfig (
      utils.systemValue {
        linux = defaultModules;
        darwin = defaultModules;
        wsl = { };
      }
    );
}
