{ den, lib, ... }: {
  boot.systemd-boot =
  let
    boot = den.ful.boot;
  in {
    includes = [ boot.core ];

    nixos = { host, ... }: {
      boot.loader.systemd-boot = {
        enable = true;
        editor = false; # recommended false
        configurationLimit = boot.core.entries.max;
      } // (lib.optionalAttrs (host.hasAspect boot.dualboot) {
        # https://wiki.nixos.org/wiki/Dual_Booting_NixOS_and_Windows#EFI_with_multiple_disks
        windows = boot.dualboot.windows.entries;
        edk2-uefi-shell = {
          enable = true;
          sortKey = "z_edk2"; # put last
        };
      });
    };
  };
}
