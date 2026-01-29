{ lib, ... }@inputs:
with lib.custom;
modules.mkDefaultsModule inputs ./. {
  options = {
    rc = lib.mkOption {
      type = with lib.types; listOf anything; # list of str or (str -> str)
      default = [ ];
      description = "Shell functions to include";
    };
  };
  config =
    { setDefaultSubconfig, ... }:
    lib.attrsets.recursiveUpdate
      (setDefaultSubconfig {
        aliases.enable = true;
        input.enable = true;
        bash = {
          enable = true;
          blesh.enable = true;
        };
        prompt.starship = {
          enable = true;
          preset = "omarchy";
        };
      })
      {
        home.shell.enableShellIntegration = false; # integrate manually
      };

}
