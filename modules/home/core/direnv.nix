{
  config,
  lib,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "core"
    "direnv"
  ];
  mkConfig =
    { ... }:
    {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
}
