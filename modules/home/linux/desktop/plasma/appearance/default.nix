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
  ];
  mkConfig =
    { ... }:
    {
      programs.plasma.workspace = {
        splashScreen.theme = "None";
      };
    };
}
