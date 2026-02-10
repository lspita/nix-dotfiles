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
        settings = optionals.ifNotNull { } (fromTOML (
          builtins.readFile ./presets/${self.preset}.toml
        )) self.preset;
      };
      custom.shell.rc = lib.mkAfter [ (shell: ''eval "$(starship init ${shell})"'') ];
    };
}
