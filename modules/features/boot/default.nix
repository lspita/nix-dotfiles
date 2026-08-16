{
  den = {
    quirks.windowsEntries.description = "Windows boot entries";

    aspects.boot = {
      nixos.boot = {
        # https://wiki.nixos.org/wiki/Linux_kernel
        loader = {
          timeout = null;
          efi.canTouchEfiVariables = true;
        };
        tmp.cleanOnBoot = true;
      };

      dualboot = {
        # https://nixos.wiki/wiki/Dual_Booting_NixOS_and_Windows#System_time
        nixos.time.hardwareClockInLocalTime = true;
      };
    };
  };
}
