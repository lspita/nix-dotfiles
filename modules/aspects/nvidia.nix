{
  den.aspects.nvidia =
    { config, lib, ... }:
    {
      imports = [
        {
          options = {
            openDrivers.enable = lib.mkEnableOption "open source drivers" // {
              default = true;
            };
            wayland.enable = lib.mkEnableOption "wayland support" // {
              default = true;
            };
            powerManagement.enable = lib.mkEnableOption "nvidia power management" // {
              default = true;
            };
            cuda.enable = lib.mkEnableOption "cuda support" // {
              default = true;
            };
          };
        }
      ];

      nixos = {
        # https://wiki.nixos.org/wiki/NVIDIA
        # https://nixos.wiki/wiki/Nvidia
        services.xserver.videoDrivers = [ "nvidia" ];
        hardware.nvidia = {
          inherit (config) powerManagement;
          open = config.openDrivers.enable;
          modesetting.enable = config.wayland.enable;
        };
      };

      os.nixpkgs.config.cudaSupport = config.cuda.enable;
      homeManager.nixpkgs.config.cudaSupport = config.cuda.enable;
    };
}
