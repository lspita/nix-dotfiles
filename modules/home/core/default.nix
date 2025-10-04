{ config, lib, ... }:
with lib.custom;
modules.mkDefaultsModule config ./. {
  config =
    { setDefaultModules, ... }:
    setDefaultModules {
      fonts.enable = true;
      direnv.enable = true;
      environment.enable = true;
      git.enable = true;
      nh.enable = true;
      wget.enable = true;
    };
}
