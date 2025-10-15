{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./power.nix {
  config = {
    powerManagement.enable = true;
    boot.kernelParams = [ "usbcore.autosuspend=-1" ]; # do not turn off fingerprint reader
    systemd.sleep.extraConfig = ''
      AllowHibernation=no
      AllowHybridSleep=no
      AllowSuspendThenHibernate=no
    '';
  };
}
