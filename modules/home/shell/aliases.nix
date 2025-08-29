{ customLib, config, ... }:
customLib.mkModule {
  inherit config;
  path = [
    "shell"
    "aliases"
  ];
  mkConfig =
    { ... }:
    {
      home.shellAliases = {
        ll = "ls -al";
        la = "ls -a";
      };
    };
}
