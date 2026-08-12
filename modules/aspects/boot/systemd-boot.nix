{ den, lib, ... }: {
  den.aspects.boot.systemd-boot =
    let
      inherit (den.aspects) boot;
    in
    {
      includes = [ boot ];

      nixos = { windowsEntries, host, ... }: {
        boot.loader.systemd-boot = {
          enable = true;
          editor = false; # recommended false
          configurationLimit = 10;
        }
        // (lib.optionalAttrs (host.hasAspect boot.dualboot) {
          # https://wiki.nixos.org/wiki/Dual_Booting_NixOS_and_Windows#EFI_with_multiple_disks
          windows = windowsEntries;
          edk2-uefi-shell = {
            enable = true;
            sortKey = "z_edk2"; # put last
          };
        });
      };
    };
}
