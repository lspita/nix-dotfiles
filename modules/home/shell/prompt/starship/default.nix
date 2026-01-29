{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./. {
  options = {
    preset = lib.mkOption {
      type = with lib.types; nullOr str;
      default = null;
      description = "starship preset to use";
    };
  };
  config =
    { self, ... }:
    {
      programs.starship = {
        enable = true;
        settings =
          if isNull self.preset then { } else fromTOML (builtins.readFile ./presets/${self.preset}.toml);
      };
      custom.shell.rc = lib.mkAfter [ (shell: ''eval "$(starship init ${shell})"'') ];
    };
}
