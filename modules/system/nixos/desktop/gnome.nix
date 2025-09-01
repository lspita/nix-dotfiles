{
  config,
  customLib,
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
  };
  mkConfig =
    { cfg }:
    {
      services = {
        desktopManager.gnome.enable = true;
        gnome.gcr-ssh-agent.enable = cfg.sshAgent.enable;
      };
    };
}
