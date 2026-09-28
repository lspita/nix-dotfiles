{ lib, ... }:
{
  den = {
    schema.user.options.fonts =
      let
        mkFontOption = type: {
          name = lib.mkOption {
            type = with lib.types; nullOr str;
            default = null;
            description = "Font to use (${type})";
          };
          size = lib.mkOption {
            type = with lib.types; nullOr int;
            default = null;
            description = "Font size (${type})";
          };
        };
      in
      {
        normal = mkFontOption "normal";
        monospace = mkFontOption "monospace";
      };

    aspects.font = pkgsFn: {
      os = { pkgs, ... }: {
        fonts.packages = pkgsFn pkgs;
      };
    };
  };
}
