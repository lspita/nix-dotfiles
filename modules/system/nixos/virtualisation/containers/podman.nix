{
  lib,
  pkgs,
  vars,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./podman.nix {
  options = {
    autoPrune = {
      enable = modules.mkEnableOption true "podman auto pruning";
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
    setGroup = modules.mkEnableOption true "podman group for the user";
    defaultNetworkDns = modules.mkEnableOption true "podman default network DNS";
    docker = {
      replaceSocket = modules.mkEnableOption false "docker socket replacement";
      alias = modules.mkEnableOption false "podman docker alias";
    };
    composeProvider = lib.mkOption {
      type = with lib.types; str;
      default = "podman-compose";
      description = "The container backend to use for compose files.";
    };
  };
  config =
    { self, ... }:
    {
      assertions = [
        {
          assertion = !(packages.isInstalled inputs "docker") || (with self.docker; !replaceSocket && !alias);
          message = "Podman cannot override docker if it's installed";
        }
      ];
      # https://wiki.nixos.org/wiki/Podman
      virtualisation.podman = {
        inherit (self) autoPrune;
        enable = true;
        # Required for containers under podman-compose to be able to talk to each other.
        defaultNetwork.settings.dns_enabled = self.defaultNetworkDns;
        dockerCompat = self.docker.alias;
        dockerSocket.enable = self.docker.replaceSocket;
      };
      environment = {
        systemPackages = with pkgs; [
          podman-compose
        ];
        sessionVariables = {
          PODMAN_COMPOSE_PROVIDER = self.composeProvider;
        };
      };
      users.users.${vars.user.username}.extraGroups = if self.setGroup then [ "podman" ] else [ ];
    };
}
