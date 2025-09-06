{
  config,
  customLib,
  ...
}:
customLib.mkDefaultsModule {
  inherit config;
  importPath = ./.;
  path = [
    "linux"
    "desktop"
    "plasma"
    "appearance"
    "theme"
  ];
}
