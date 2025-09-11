{
  config,
  customLib,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "nixos"
    "core"
    "power"
  ];
  mkConfig =
    { ... }:
    {
      powerManagement.enable = true;
    };
}
