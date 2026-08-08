{ lib, den, ... }: {
  den = {
    schema.host = {
      options = {
        graphics = lib.mkOption {
          type =
            with lib.types;
            nullOr (enum [
              "nvidia"
              "intel"
              "amd"
            ]);
          default = null;
          description = "Graphics family used by the host";
        };
        stateVersion = lib.mkOption {
          type = lib.types.str;
          description = "State version of the system.";
        };
      };

      includes = with den.aspects; [ host ];
    };

    aspects.host = { host, ... }: {
      includes = with den.batteries; [
        hostname
        (den.ful.graphics.${host.graphics} or { })
      ];

      os = {
        system.stateVersion = host.stateVersion;
        home-manager = {
          useGlobalPkgs = lib.mkDefault true;
          useUserPackages = lib.mkDefault true;
        };
      };
      provides.to-users.homeManager.home.stateVersion = host.stateVersion;
    };
  };
}
