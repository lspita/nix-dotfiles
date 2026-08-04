{
  den.aspects.dualBoot = { config, lib, ... }: {
    imports = [
      {
        options = {
          windows.entries = lib.mkOption {
            type = with lib.types; attrs;
            default = { };
            example = {
              "windows11" = {
                title = "Windows 11";
                # To discover the EFI device handle:
                # 1. boot to edk2
                # 2. run `map -c`,
                # 3. `<ENTRYNAME>:` to enter one
                # 4. `ls` to show files, check for Microsoft
                efiDeviceHandle = "FS1";
                sortKey = "_windows11"; # put it at the top
              };
            };
            description = "List of Windows entries to add to the boot menu.";
          };
          hardwareClockInLocalTime = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = "Whether to enable hardware clock in local time.";
          };
        };
      }
    ];

    nixos = {
      boot.loader.systemd-boot = {
        # https://wiki.nixos.org/wiki/Dual_Booting_NixOS_and_Windows#EFI_with_multiple_disks
        windows = config.windows.entries;
        edk2-uefi-shell = {
          enable = true;
          sortKey = "z_edk2"; # put last
        };
      };
      time = {
        # https://nixos.wiki/wiki/Dual_Booting_NixOS_and_Windows#System_time
        inherit (config) hardwareClockInLocalTime;
      };
    };
  };
}
