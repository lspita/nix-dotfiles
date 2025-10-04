{ config, lib, ... }:
with lib.custom;
modules.mkDefaultsModule config ./. {
  config =
    { setDefaultModules, ... }:
    setDefaultModules {
      boot = {
        enable = true;
        plymouth.enable = true;
      };
      filesystem.enable = true;
      power.enable = true;
      wayland.enable = true;
      locale.enable = true;
      bluetooth.enable = true;
      audio.pipewire.enable = true;
      network.networkmanager.enable = true;
    };
}
