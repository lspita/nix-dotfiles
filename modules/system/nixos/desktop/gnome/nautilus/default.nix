{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    let
      gnomeTerminal = gnome.defaults.terminal.program;
      varsTerminal = vars.linux.defaultApps.terminal.program;
    in
    setDefaultSubconfig {
      openAnyTerminal.enable = varsTerminal != null && varsTerminal != gnomeTerminal;
    };
}
