{ customLib, config, ... }:
customLib.mkModule {
  inherit config;
  path = [
    "shell"
    "bash"
  ];
  mkConfig =
    { ... }:
    {
      programs.bash = {
        enable = true;
        enableCompletion = true;
      };
    };
}
