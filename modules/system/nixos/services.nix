{
  config,
  customLib,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
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
