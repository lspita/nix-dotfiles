{ lib, den, ... }: {
  den.schema.host = {
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

    includes = [
      den.aspects.host
    ];
  };
}
