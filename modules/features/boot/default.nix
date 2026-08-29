{ lib, ... }: {
  den.aspects.boot = {
    nixos.boot = {
      # https://wiki.nixos.org/wiki/Linux_kernel
      loader = {
        timeout = null;
        efi.canTouchEfiVariables = true;
      };
      tmp.cleanOnBoot = true;
    };

    dualboot.nixos = {
      # https://nixos.wiki/wiki/Dual_Booting_NixOS_and_Windows#System_time
      options.features.boot.dualboot.windows.entries = lib.mkOption {
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
      };
      config.time.hardwareClockInLocalTime = true;
    };
  };
}
