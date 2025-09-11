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
      systemd.sleep.extraConfig = ''
        AllowHibernation=no
        AllowHybridSleep=no
        AllowSuspendThenHibernate=no
      '';
    };
}
