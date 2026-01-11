{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    let
      gnomeTerminal = gnome.defaults.terminal;
      varsTerminal = vars.linux.defaultApps.terminal;
    in
    setDefaultSubconfig {
      openAnyTerminal.enable = varsTerminal != null && varsTerminal != gnomeTerminal;
    };
}
