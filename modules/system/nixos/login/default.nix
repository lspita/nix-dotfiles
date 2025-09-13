{
  customLib,
  config,
  lib,
  ...
}:
customLib.mkDefaultsModule {
  inherit config;
  importPath = ./.;
  path = [
    "nixos"
    "login"
  ];
}
