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
        (notNullAndDifferentFrom desktop "org.gnome.Console.desktop")
        && (notNullAndDifferentFrom program "kgx");
    };
}
