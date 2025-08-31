{
  config,
  customLib,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "core"
    "nix"
  ];
  mkConfig =
    { ... }:
    {
      nix.settings.auto-optimise-store = true;
    };
}
