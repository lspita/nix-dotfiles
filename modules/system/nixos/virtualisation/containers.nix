{
  config,
  lib,
  vars,
  ...
}:
with lib.custom;
modules.mkModule config ./containers.nix {
  options = {
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
      rootless = utils.mkTrueEnableOption "user permissions for rootless docker";
    };
    podman.enable = lib.mkEnableOption "podman";
  };
  config =
    { self, ... }:
    with self;
    {
      virtualisation = {
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
        with docker;
        if enable && rootless then [ "docker" ] else [ ];
    };
}
