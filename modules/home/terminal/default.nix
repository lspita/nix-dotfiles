{
  config,
  lib,
  ...
}:
lib.custom.mkDefaultsModule {
  inherit config;
  importPath = ./.;
  path = [
    "terminal"
  ];
}
