{ config, lib, ... }:
with lib.custom;
modules.mkDefaultsModule config ./. {
  config =
    { setDefaultModules, ... }:
    setDefaultModules {
      nh.enable = true;
      direnv.enable = true;
      gh.enable = true;
      fastfetch.enable = true;
      lazycli.enable = true;
      lazygit.enable = true;
      lazydocker.enable = true;
    };
}
