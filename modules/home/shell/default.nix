{
  config,
  lib,
  ...
}:
lib.custom.mkDefaultsModule {
  inherit config;
  importPath = ./.;
  path = [
    "shell"
  ];
  mkConfig =
    { ... }:
    with lib;
    {
      custom.modules.shell.aliases.enable = mkDefault true;
      home.shell.enableShellIntegration = mkDefault true;
    };
}
