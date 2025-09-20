{
  config,
  lib,
  pkgs,
  ...
}:
lib.custom.mkProgramModule {
  inherit config;
  path = [
    "editor"
    "vscode"
  ];
  packages = pkgs.vscode;
}
