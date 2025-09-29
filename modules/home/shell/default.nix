{ config, lib, ... }:
with lib.custom;
modules.mkDefaultsModule config ./. {
  options = {
    functions = lib.mkOption {
      type = with lib.types; attrs;
      default = { };
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
