{
  config,
  customLib,
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
        clean = with vars.nix.cleaning; {
          enable = true;
          dates = frequency;
          extraArgs = "--keep-since ${deleteOlderThan} --keep ${builtins.toString maxGenerations}";
        };
        flake = customLib.dotPath config ".";
      };
    };
}
