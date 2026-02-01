{ lib, hostInfo, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    let
      wsl = hostInfo.wsl;
    in
    setDefaultSubconfig {
      boot = {
        enable = !wsl;
        plymouth.enable = !wsl;
      };
      graphics = {
        enableDefaults = !wsl;
      }
      // (optionals.ifNotNull { } {
        ${hostInfo.graphics}.enable = !wsl;
      } hostInfo.graphics);
      filesystem.exfat.enable = !wsl;
      power.enable = !wsl;
      wayland.enable = !wsl;
      locale.enableDefaults = !wsl;
      bluetooth.enable = !wsl;
      audio.pipewire.enable = !wsl;
      network.networkmanager.enable = !wsl;
      wsl.enable = wsl;
      documentation.enable = true;
      nix-ld.enable = true;
    };
}
