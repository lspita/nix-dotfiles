{ customLib, config, ... }:
{
  imports = customLib.scanPaths ./.;
}
// customLib.mkModule {
  inherit config;
  path = [
    "shell"
  ];
  enableOption = "enableDefaults";
  name = "default shell settings";
  mkConfig =
    { ... }:
    {
      modules.shell.aliases.enable = true;
      home.shell.enableShellIntegration = true;
    };
}
