{
  config,
  lib,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "core"
    "nh"
  ];
  mkConfig =
    { ... }:
    {
      programs.nh = {
        enable = true;
        flake = lib.custom.dotPath config ".";
      };
    };
}
