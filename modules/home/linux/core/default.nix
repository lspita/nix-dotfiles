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
      modules.linux.core = {
        xdg.enable = true;
      };
    };
}
