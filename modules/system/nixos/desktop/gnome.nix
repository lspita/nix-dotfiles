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
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to enable gnome ssh agent";
      };
    };
    networkManagerWifiFix = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to enable the network manager wifi fix (if using network manager)";
    };
  };
  mkConfig =
    { cfg }:
    {
      services = {
        desktopManager.gnome.enable = true;
        gnome.gcr-ssh-agent.enable = cfg.sshAgent.enable;
      };
      networking.networkmanager.settings =
        lib.mkIf (cfg.networkManagerWifiFix && config.networking.networkmanager.enable)
          {
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
