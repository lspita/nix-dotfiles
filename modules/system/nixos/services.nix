{
  config,
  customLib,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "modules"
    "system"
    "nixos"
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
