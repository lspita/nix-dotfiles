{ customLib, config, ... }:
customLib.mkDefaultsModule {
  inherit config;
  importPath = ./.;
  path = [
    "core"
  ];
  mkConfig =
    { ... }:
    {
      modules.core = {
        git.enable = true;
        nix.enable = true;
      };
    };
}
