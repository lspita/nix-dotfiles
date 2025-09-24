{ config, lib, ... }:
lib.custom.mkModule {
  inherit config;
  imports = [ ./blesh.nix ];
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
