{ den, ... }: {
  den.aspects.systemd-boot = {
    includes = with den.aspects; [
      boot
      (den.lib.policy.when ({ host, ... }: host.hasAspect dualboot) {
        nixos.boot.loader.systemd-boot = {
          # https://wiki.nixos.org/wiki/Dual_Booting_NixOS_and_Windows#EFI_with_multiple_disks
          windows = den.aspects.dualboot.windows.entries;
          edk2-uefi-shell = {
            enable = true;
            sortKey = "z_edk2"; # put last
          };
        };
      })
    ];

    nixos.boot.loader.systemd-boot = {
      enable = true;
      editor = false; # recommended false
      configurationLimit = den.aspects.boot.entries.max;
    };
  };
}
