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
      custom.modules.core = {
        environment.enable = true;
        git.enable = true;
        nix.enable = true;
        nh.enable = true;
      };
    };
}
