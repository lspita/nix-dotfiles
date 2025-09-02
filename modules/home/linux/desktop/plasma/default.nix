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
  ];
  mkConfig =
    { ... }:
    {
      custom.modules.linux.desktop.plasma = {
        settings.enable = true;
        theming.enable = true;
      };
    };
}
