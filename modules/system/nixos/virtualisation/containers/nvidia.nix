{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./nvidia.nix {
  config = {
    # https://wiki.nixos.org/wiki/Docker#NVIDIA_Docker_Containers
    hardware.nvidia-container-toolkit.enable = true;
    virtualisation.docker =
      let
        dockerConfig = {
          daemon.settings.features.cdi = true;
        };
      in
      lib.mkMerge [
        dockerConfig
        {
          rootless = dockerConfig;
        }
      ];
  };
}
