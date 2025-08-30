{ customLib, config, ... }:
customLib.mkDefaultsModule {
  inherit config;
  importPath = ./.;
  path = [
    "shell"
  ];
  mkConfig =
    { ... }:
    {
      modules.shell.aliases.enable = true;
      home.shell.enableShellIntegration = true;
    };
}
