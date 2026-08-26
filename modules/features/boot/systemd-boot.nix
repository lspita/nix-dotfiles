{
  den,
  lib,
  lib2,
  ...
}:
{
  den.aspects.boot.systemd-boot =
    let
      inherit (den.aspects) boot;
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
        { host, windowsEntries, ... }:
        lib.optionalAttrs (host.hasAspect boot.dualboot) {
          boot.loader.systemd-boot = {
            # https://wiki.nixos.org/wiki/Dual_Booting_NixOS_and_Windows#EFI_with_multiple_disks
            windows = lib2.boot.mergeWindowsEntries windowsEntries;
            edk2-uefi-shell = {
              enable = true;
              sortKey = "z_edk2"; # put last
            };
          };
        };
    };
}
