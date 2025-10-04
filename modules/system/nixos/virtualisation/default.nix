{ config, lib, ... }:
with lib.custom;
modules.mkDefaultsModule config ./. {
  config =
    { setDefaultModules, ... }:
    setDefaultModules {
      docker.enable = true;
      podman.enable = true;
    };
}
