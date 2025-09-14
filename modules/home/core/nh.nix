{
  config,
  lib,
  vars,
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
        clean = with vars.nix.cleaning; {
          enable = true;
          dates = frequency;
          extraArgs = "--keep-since ${deleteOlderThan} --keep ${builtins.toString maxGenerations}";
        };
        flake = lib.custom.dotPath config ".";
      };
    };
}
