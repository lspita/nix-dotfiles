{ lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    setDefaultSubconfig (
      utils.systemValue {
        linux = {
          boot = {
            enable = true;
            plymouth.enable = true;
          };
          filesystem.exfat.enable = true;
          power.enable = true;
          wayland.enable = true;
          locale.enable = true;
          bluetooth.enable = true;
          audio.pipewire.enable = true;
          network.networkmanager.enable = true;
          documentation.enable = true;
          nix-ld.enable = true;
        };
        wsl = {
          wsl.enable = true;
          documentation.enable = true;
          nix-ld.enable = true;
        };
        darwin = { };
      }
    );
}
