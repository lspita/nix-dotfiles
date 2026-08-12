{ den, ... }: {
  den.aspects.graphics.nvidia = {
    includes = [
      (den.batteries.unfree [ "nvidia-x11" "nvidia-settings" ])
      (den.aspects.nix.nixpkgs { config.cudaSupport = true; })
    ];

    nixos = {
      # https://wiki.nixos.org/wiki/NVIDIA
      # https://nixos.wiki/wiki/Nvidia
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        powerManagement.enable = true;
        open = true;
        modesetting.enable = true; # wayland
      };
    };
  };
}
