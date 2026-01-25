{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    let
      gnomeTerminal = gnome.defaults.apps.terminal;
      varsTerminal = vars.linux.defaultApps.terminal;
    in
    setDefaultSubconfig {
      # google drive mount will not work until libsoup is not at a secure version
      # https://github.com/NixOS/nixpkgs/issues/438121
      openAnyTerminal.enable = varsTerminal != null && varsTerminal != gnomeTerminal;
    };
}
