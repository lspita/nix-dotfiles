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
      includes = [
        den.batteries.hostname
        (
          { host, ... }:
          let
            graphicsAspects = with den.aspects; {
              nvidia = nvidia;
              intel = intel-graphics;
            };
          in
          {
            includes = [ graphicsAspects.${host.graphics} or { } ];
          }
        )
      ];

      os.system.stateVersion = host.stateVersion;
      provides.to-users.homeManager.home.stateVersion = host.stateVersion;
    };
  };
}
