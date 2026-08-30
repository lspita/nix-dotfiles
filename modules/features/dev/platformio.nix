{
  den.aspects.dev.platformio.nixos = { pkgs, ... }: {
    # https://wiki.nixos.org/wiki/Platformio
    services.udev.packages = with pkgs; [
      platformio-core.udev
      openocd
    ];
  };
}
