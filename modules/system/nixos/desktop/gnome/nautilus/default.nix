{
  config,
  lib,
  vars,
  ...
}:
with lib.custom;
modules.mkDefaultsModule config ./. {
  config =
    { setDefaultModules, ... }:
    setDefaultModules {
      openAnyTerminal.enable =
        with vars.linux.defaultApps.terminal;
        desktop != "org.gnome.Console.desktop" && program != "kgx";
    };
}
