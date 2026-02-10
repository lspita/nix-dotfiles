{ lib, vars, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./networkmanager.nix {
  options = {
    wifiLimitedConnectivityFix = modules.mkEnableOption true "network manager limited wifi connectivity fix";
  };
  config =
    { self, ... }:
    {
      networking.networkmanager = {
        enable = true;
        settings = lib.attrsets.optionalAttrs self.wifiLimitedConnectivityFix {
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
