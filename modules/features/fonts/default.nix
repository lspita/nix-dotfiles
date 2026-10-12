{ lib, ... }:
{
  den = {
    schema.host.options.fonts =
      let
        fontType = lib.types.submodule {
          options = {
            name = lib.mkOption {
              type = lib.types.str;
              description = "Font name";
            };
            size = lib.mkOption {
              type = with lib.types; nullOr int;
              default = null;
              description = "Font size";
            };
          };
        };
        mkFontOption =
          fontName:
          lib.mkOption {
            type = lib.types.nullOr fontType;
            default = null;
            description = "${fontName} font to use";
          };
      in
      {
        normal = mkFontOption "Normal";
        monospace = mkFontOption "Monospace";
      };

    aspects.font = pkgsFn: {
      os = { pkgs, ... }: {
        fonts.packages = pkgsFn pkgs;
      };
    };
  };
}
