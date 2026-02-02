{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./. {
  options = {
    maxEntries = lib.mkOption {
      type = lib.types.int;
      default = 10;
      description = "Maximum number of latest generations in the boot menu.";
    };
    dualBoot = {
      enable = modules.mkEnableOption false "dual boot";
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
    };
    entriesTimeout = lib.mkOption {
      type = with lib.types; nullOr int;
      default = null;
      description = "Timeout (in seconds) until loader boots the default menu item.";
    };
  };
  config =
    { self, ... }:
    {
      boot = {
        loader = {
          systemd-boot = {
            enable = true;
            editor = false; # recommended false https://search.nixos.org/options?channel=unstable&show=boot.loader.systemd-boot.editor
            configurationLimit = self.maxEntries;
          }
          // (
            with self.dualBoot;
            if enable then
              {
                # https://wiki.nixos.org/wiki/Dual_Booting_NixOS_and_Windows#EFI_with_multiple_disks
                windows = windows.entries;
                edk2-uefi-shell = {
                  enable = true;
                  sortKey = "z_edk2"; # put last
                };
              }
            else
              { }
          );
          efi.canTouchEfiVariables = true;
          timeout = optionals.getNotNull (if self.dualBoot.enable then 5 else 0) self.entriesTimeout; # spam space to show entries selection
        };
        tmp.cleanOnBoot = true;
      };
    };
}
