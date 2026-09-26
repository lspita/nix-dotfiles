{ lib, den, ... }: {
  den = {
    schema.host = {
      options = {
        stateVersion = lib.mkOption {
          type = lib.types.str;
          description = "State version of the system.";
        };
      };
      includes = with den.aspects; [ host ];
    };

    aspects.host = { host, ... }:{
        includes = with den.batteries; [ hostname ];

        os.system.stateVersion = host.stateVersion;
        provides.to-users.homeManager.home.stateVersion = host.stateVersion;
      };
  };
}
