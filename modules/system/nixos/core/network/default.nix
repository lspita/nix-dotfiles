{ customLib, config, ... }:
customLib.mkDefaultsModule {
  inherit config;
  importPath = ./.;
  path = [
    "nixos"
    "core"
    "network"
  ];
}
