{ systemType, lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  config =
    { setDefaultSubconfig, ... }:
    let
      wsl = systemType == "wsl";
    in
    setDefaultSubconfig (
      platform.systemTypeValue {
        linux = {
          boot = {
            enable = !wsl;
            plymouth.enable = !wsl;
          };
          filesystem.exfat.enable = !wsl;
          power.enable = !wsl;
          wayland.enable = !wsl;
          locale.enable = !wsl;
          bluetooth.enable = !wsl;
          audio.pipewire.enable = !wsl;
          network.networkmanager.enable = !wsl;
          wsl.enable = wsl;
          documentation.enable = true;
          nix-ld.enable = true;
        };
        darwin = { };
      }
    );
}
