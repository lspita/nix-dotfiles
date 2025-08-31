{
  config,
  customLib,
  lib,
  ...
}:
customLib.mkModule {
  inherit config;
  path = [
    "nixos"
    "desktop"
    "gnome"
  ];
  extraOptions = {
    sshAgent = {
      enable = customLib.mkTrueEnableOption "gnome ssh agent";
    };
    networkManagerWifiFix = customLib.mkTrueEnableOption "gnome network manager wifi fix";
  };
  mkConfig =
    { cfg }:
    {
      assertions = [
        {
          assertion = !cfg.networkManagerWifiFix || config.networking.networkmanager.enable;
          message = "Cannot enable option networkManagerWifiFix if networkmanager is disabled.";
        }
      ];

      services = {
        desktopManager.gnome.enable = true;
        gnome.gcr-ssh-agent.enable = cfg.sshAgent.enable;
      };
      networking.networkmanager.settings =
        # networkmanager is enabled because of assertion, but check anyways
        lib.mkIf (cfg.networkManagerWifiFix && config.networking.networkmanager.enable) {
          # fix wifi considered without internet access
          # https://discourse.nixos.org/t/is-gnome-supposed-to-detect-captive-portals/44417/4
          # converted to settings attribute because extraConfig is not supported anymore
          connectivity = {
            uri = "http://google.cn/generate_204";
            response = "";
          };
        };
    };
}
