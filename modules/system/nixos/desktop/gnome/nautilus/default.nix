{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultModules, ... }:
    setDefaultModules {
      openAnyTerminal.enable =
        with vars.linux.defaultApps.terminal;
        desktop != "org.gnome.Console.desktop" && program != "kgx";
    };
}
