{
  den.aspects.graphics.intel.nixos = { pkgs, ... }: {
    # https://wiki.nixos.org/wiki/Intel_Graphics
    services.xserver.videoDrivers = [ "modesetting" ];
    hardware.graphics.extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
      intel-compute-runtime # OpenCL (NEO) + Level Zero for Arc/Xe
    ];
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
    };
  };
}
