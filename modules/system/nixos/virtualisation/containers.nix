{
  config,
  lib,
  vars,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "nixos"
    "virtualisation"
    "containers"
  ];
  extraOptions = {
    autoPrune = {
      enable = lib.mkEnableOption "container auto pruning";
      dates = lib.mkOption {
        type = with lib.types; str;
        default = "weekly";
        description = "Specification (in the format described by systemd.time(7)) of the time at which the prune will occur.";
      };
      flags = lib.mkOption {
        type = with lib.types; listOf str;
        default = [ "--all" ];
        description = "Any additional flags passed to the prune command.";
      };
    };
    docker = {
      enable = lib.mkEnableOption "docker";
      rootless = lib.custom.mkTrueEnableOption "user permissions for rootless docker";
    };
    podman.enable = lib.mkEnableOption "podman";
  };
  mkConfig =
    { cfg }:
    {
      virtualisation = with cfg; {
        docker = {
          inherit autoPrune;
          inherit (docker) enable;
        };
        podman = {
          inherit autoPrune;
          inherit (podman) enable;
        };
      };
      users.users.${vars.user.username}.extraGroups =
        with cfg.docker;
        if enable && rootless then [ "docker" ] else [ ];
    };
}
