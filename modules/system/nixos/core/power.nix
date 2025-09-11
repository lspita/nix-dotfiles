{
  config,
  customLib,
  pkgs,
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
