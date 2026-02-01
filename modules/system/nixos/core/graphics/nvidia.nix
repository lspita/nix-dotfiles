{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./nvidia.nix {
  options = {
    openDrivers.enable = modules.mkEnableOption true "open source drivers";
    wayland.enable = modules.mkEnableOption true "wayland support";
  };
  config =
    { self, ... }:
    {
      # https://wiki.nixos.org/wiki/NVIDIA
      # https://nixos.wiki/wiki/Nvidia
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        open = self.openDrivers.enable;
        modesetting.enable = self.wayland.enable;
      };
    };
}
