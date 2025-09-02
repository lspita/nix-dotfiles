{
  config,
  customLib,
  vars,
  lib,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "nixos"
    "core"
    "network"
    "networkmanager"
  ];
  extraOptions = {
    wifiLimitedConnectivityFix = customLib.mkTrueEnableOption "network manager limited wifi connectivity fix";
  };
  mkConfig =
    { cfg }:
    {
      networking.networkmanager = {
        enable = true;
        settings = lib.mkIf cfg.wifiLimitedConnectivityFix {
          # fix wifi considered without internet access
          # https://discourse.nixos.org/t/is-gnome-supposed-to-detect-captive-portals/44417/4
          # converted to settings attribute because extraConfig is not supported anymore
          connectivity = {
            uri = "http://google.cn/generate_204";
            response = "";
          };
        };
      };
      users.users.${vars.user.username}.extraGroups = [ "networkmanager" ];
    };
}
