{ config, lib, ... }:
with lib.custom;
modules.mkDefaultsModule config ./. {
  config =
    { setDefaultModules, ... }:
    (setDefaultModules {
      aliases.enable = true;
    })
    // {
      home.shell.enableShellIntegration = lib.mkDefault true;
    };

}
