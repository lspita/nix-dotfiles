{ config, lib, ... }:
lib.custom.mkModule {
  inherit config;
  path = [
    "shell"
    "bash"
  ];
  mkConfig =
    { ... }:
    {
      programs.bash.enable = true;
    };
}
