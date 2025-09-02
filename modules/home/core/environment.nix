{
  config,
  customLib,
  vars,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "core"
    "environment"
  ];
  mkConfig =
    { ... }:
    {
      home.sessionVariables = with vars.defaultApps; {
        EDITOR = editor;
        VISUAL = editor;
        BROWSER = browser;
      };
    };
}
