{ config, lib, ... }:
with lib.custom;
modules.mkDefaultsModule config ./. {
  options = {
    rc = lib.mkOption {
      type = with lib.types; listOf anything; # list of str or (str -> str)
      default = [ ];
      description = "Shell functions to include";
    };
  };
  config =
    { setDefaultModules, ... }:
    lib.attrsets.recursiveUpdate
      (setDefaultModules {
        aliases.enable = true;
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
        home.shell.enableShellIntegration = lib.mkDefault true;
      };

}
