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
      custom.modules.shell.aliases.enable = true;
      home.shell.enableShellIntegration = true;
    };
}
