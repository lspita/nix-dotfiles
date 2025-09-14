{
  config,
  lib,
  vars,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "core"
    "environment"
  ];
  mkConfig =
    { ... }:
    {
      home.sessionVariables = with vars.linux.defaultApps; {
        EDITOR = editor.program;
        VISUAL = editor.program;
        BROWSER = browser.program;
      };
    };
}
