{ den, ... }: {
  den.aspects.virtualisation.podman = {
    includes = with den.aspects; [ virtualisation.docker.nvidia ];

    nixos =
      {
        user,
        pkgs,
        options,
        ...
      }:
      let
        podmanPackage = options.virtualisation.podman.package.default;
        composePackage = pkgs.podman-compose;
      in
      {
        # https://wiki.nixos.org/wiki/Podman
        virtualisation.podman = {
          enable = true;
          autoPrune = {
            enable = true;
            dates = "weekly";
            flags = [ "--all" ];
          };
          package = podmanPackage;
          # make containers under podman-compose to be able to talk to each other.
          defaultNetwork.settings.dns_enabled = true;
        };
        users.users.${user.userName}.extraGroups = [ "podman" ];
        environment.systemPackages = [ composePackage ];
      };

    docker = {
      socket.nixos.virtualisation.podman.dockerSocket.enable = true;
      alias.nixos.virtualisation.podman.dockerCompat = true;
    };
  };
}
