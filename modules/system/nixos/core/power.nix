{
  config,
  customLib,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "nixos"
    "core"
    "power"
  ];
  mkConfig =
    { ... }:
    {
      powerManagement.enable = true;
      boot.kernelParams = [ "usbcore.autosuspend=-1" ]; # do not turn off fingerprint reader
      systemd.sleep.extraConfig = ''
        AllowHibernation=no
        AllowHybridSleep=no
        AllowSuspendThenHibernate=no
      '';
    };
}
