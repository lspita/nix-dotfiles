{ den, lib, ... }: {
  den.aspects.graphics.nvidia = {
    includes = [
      (den.batteries.unfree [
        "nvidia-x11"
        "nvidia-settings"
      ])
    ]
    ++ (with den.aspects.graphics.nvidia; [
      cuda
      wayland
    ]);

    nixos = {
      # https://wiki.nixos.org/wiki/NVIDIA
      # https://nixos.wiki/wiki/Nvidia
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        powerManagement.enable = true;
        open = true;
      };
    };

    cuda.os.nixpkgs.config.cudaSupport = true;
    wayland.nixos =
      { host, ... }:
      lib.optionalAttrs (host.hasAspect den.aspects.graphics.wayland) {
        hardware.nvidia.modesetting.enable = true;
      };
  };
}
