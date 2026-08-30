{ den, lib, ... }:
{
  den.aspects.system.boot.systemd-boot =
    let
      inherit (den.aspects.system) boot;
    in
    {
      includes = [
        boot
        boot.systemd-boot.dualboot
      ];

      nixos.boot.loader.systemd-boot = {
        enable = true;
        editor = false; # recommended false
        configurationLimit = 10;
      };

      dualboot.nixos =
        { config, host, ... }:
        lib.optionalAttrs (host.hasAspect boot.dualboot) {
          boot.loader.systemd-boot = {
            # https://wiki.nixos.org/wiki/Dual_Booting_NixOS_and_Windows#EFI_with_multiple_disks
            windows = config.features.boot.dualboot.windows.entries;
            edk2-uefi-shell = {
              enable = true;
              sortKey = "z_edk2"; # put last
            };
          };
        };
    };
}
