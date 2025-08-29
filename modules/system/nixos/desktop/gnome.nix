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
