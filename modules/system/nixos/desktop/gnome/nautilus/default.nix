{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    setDefaultSubconfig {
      openAnyTerminal.enable =
        with vars.linux.defaultApps.terminal;
        let
          notNullAndDifferentFrom = value: check: (!builtins.isNull value) && value != check;
        in
        (notNullAndDifferentFrom desktop gnome.defaults.terminal.desktop)
        && (notNullAndDifferentFrom program gnome.defaults.terminal.program);
    };
}
