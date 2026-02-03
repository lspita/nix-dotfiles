{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./. {
  config = { setDefaultSubconfig, ... }: setDefaultSubconfig { };
}
