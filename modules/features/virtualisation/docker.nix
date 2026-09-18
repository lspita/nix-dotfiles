{ den, lib, ... }: {
  den.aspects.virtualisation.docker = {
    includes = with den.aspects; [ virtualisation.docker.nvidia ];

    nixos = { user, pkgs, ... }: {
      virtualisation.docker = {
        enable = true;
        autoPrune = {
          enable = true;
          dates = "weekly";
          flags = [ "--all" ];
        };
      };
      environment.systemPackages = with pkgs; [
        docker-compose
      ];
      users.users.${user.userName}.extraGroups = [ "docker" ];
    };

    nvidia =
      { host, ... }:
      lib.optionalAttrs (host.graphics == "nvidia") {
        nixos = {
          # https://wiki.nixos.org/wiki/Docker#NVIDIA_Docker_Containers
          hardware.nvidia-container-toolkit.enable = true;
          virtualisation.docker =
            let
              dockerConfig = {
                daemon.settings.features.cdi = true;
              };
            in
            lib.mkMerge [
              dockerConfig
              {
                rootless = dockerConfig;
              }
            ];
        };
      };
  };
}
