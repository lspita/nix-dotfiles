{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./power.nix {
  config = {
    boot.kernelParams = [ "usbcore.autosuspend=-1" ]; # do not turn off fingerprint reader
    systemd.sleep.extraConfig = ''
      AllowHibernation=no
      AllowHybridSleep=no
      AllowSuspendThenHibernate=no
    '';
  };
}
