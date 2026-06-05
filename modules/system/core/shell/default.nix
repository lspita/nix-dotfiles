{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    setDefaultSubconfig (optionals.ifNotNull { } { ${vars.user.shell}.enable = true; } shell);
}
