{
  customLib,
  config,
  ...
}:
customLib.mkDefaultsModule {
  inherit config;
  importPath = ./.;
  path = [
    "terminal"
  ];
}
