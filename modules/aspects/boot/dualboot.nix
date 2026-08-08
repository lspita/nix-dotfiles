{ den, ... }: {
  boot.dualboot = { config, lib, ... }: {
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
    includes = with den.ful; [ boot.core ];

    nixos.time = {
      # https://nixos.wiki/wiki/Dual_Booting_NixOS_and_Windows#System_time
      inherit (config) hardwareClockInLocalTime;
    };
  };
}
