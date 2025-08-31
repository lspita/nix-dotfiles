{
  config,
  customLib,
  lib,
  vars,
  ...
}:
customLib.mkModule {
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
        clean =
          let
            cvars = vars.nix.cleaning;
          in
          {
            enable = true;
            dates = cvars.frequency;
            extraArgs = "--keep-since ${cvars.deleteOlderThan} --keep ${builtins.toString cvars.maxGenerations}";
          };
        flake = customLib.dotPath config ".";
      };
    };
}
