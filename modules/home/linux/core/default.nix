{ customLib, config, ... }:
customLib.mkDefaultsModule {
  inherit config;
  importPath = ./.;
  path = [
    "linux"
    "core"
  ];
  mkConfig =
    { ... }:
    {
      custom.modules.linux.core = {
        xdg.enable = true;
      };
    };
}
