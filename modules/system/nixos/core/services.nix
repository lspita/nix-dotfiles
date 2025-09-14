{ config, lib, ... }:
lib.custom.mkModule {
  inherit config;
  path = [
    "nixos"
    "core"
    "services"
  ];
  mkConfig =
    { ... }:
    {
      services = {
        fprintd.enable = true; # fingerprint
        printing.enable = true; # cups
        openssh.enable = true; # ssh
      };
    };
}
