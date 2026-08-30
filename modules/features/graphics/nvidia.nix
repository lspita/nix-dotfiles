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

    cuda.includes = with den.aspects; [
      (nix.settings {
        # https://wiki.nixos.org/wiki/CUDA#Setting_up_CUDA_Binary_Cache
        substituers = [ "https://cache.nixos-cuda.org" ];
        trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];
      })
      (nixpkgs.settings { cudaSupport = true; })
    ];
    wayland.nixos =
      { host, ... }:
      lib.optionalAttrs (host.hasAspect den.aspects.graphics.wayland) {
        hardware.nvidia.modesetting.enable = true;
      };
  };
}
