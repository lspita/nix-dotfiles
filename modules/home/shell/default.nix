{ config, lib, ... }:
with lib.custom;
modules.mkDefaultsModule config ./. {
  options = {
    rc = lib.mkOption {
      type = with lib.types; listOf anything; # list of str or (str -> str)
      default = [ ];
      description = "Shell functions to include";
    };
  };
  config =
    { setDefaultModules, ... }:
    (setDefaultModules {
      aliases.enable = true;
    })
    // {
      home.shell.enableShellIntegration = lib.mkDefault true;
    };

}
