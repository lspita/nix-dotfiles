{
  den,
  lib,
  lib2,
  ...
}:
{
  den.schema.host.options = {
    theme =
      let
        themes = den.schema.host.options.themes or { };
      in
      lib.mkOption {
        type = with lib.types; nullOr (enum (builtins.attrNames themes));
        default = null;
        description = "Preferred theme";
      };
  };

  lib2.themes = {
    selected = host: lib2.optionals.fmapNull (t: host.themes.${t}) host.theme;
  };
}
