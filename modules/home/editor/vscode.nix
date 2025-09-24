{
  config,
  lib,
  ...
}:
lib.custom.mkProgramModule {
  inherit config;
  path = [
    "editor"
    "vscode"
  ];
  programs = "vscode";
}
