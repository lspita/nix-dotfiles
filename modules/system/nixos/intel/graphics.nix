{
  config,
  lib,
  pkgs,
  ...
}:
with lib.custom;
modules.mkModule config ./graphics.nix {
  config = {
    # https://wiki.nixos.org/wiki/Intel_Graphics
    services.xserver.videoDrivers = [ "modesetting" ];
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        # For modern Intel CPU's
        intel-media-driver # Enable Hardware Acceleration
        vpl-gpu-rt # Enable QSV
      ];
    };
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
    };
  };
}
