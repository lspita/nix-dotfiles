{ config, lib, ... }:
with lib.custom;
modules.mkModule config ./. {
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
          if builtins.isNull self.preset then
            { }
          else
            builtins.fromTOML (builtins.readFile ./presets/${self.preset}.toml);
      };
    };
}
