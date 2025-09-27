{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./plymouth.nix {
  config = {
    # https://wiki.nixos.org/wiki/Plymouth
    boot = {
      plymouth = {
        enable = true;
        theme = "bgrt"; # distro logo
      };

      # silent boot
      consoleLogLevel = 3;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "udev.log_priority=3"
        "rd.systemd.show_status=auto"
      ];
    };
  };
}
