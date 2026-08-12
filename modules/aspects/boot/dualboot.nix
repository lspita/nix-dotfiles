{ den, ... }: {
  den = {
    quirks.windowsEntries.description = "Windows boot entries";

    aspects.boot.dualboot = {
      includes = with den.aspects; [ boot ];
      # https://nixos.wiki/wiki/Dual_Booting_NixOS_and_Windows#System_time
      nixos.time.hardwareClockInLocalTime = true;
    };
  };
}
