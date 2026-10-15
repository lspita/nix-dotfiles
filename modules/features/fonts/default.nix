{ lib, ... }:
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
in
{
  options.meta.fonts = lib.mkOption {
    type = lib.types.attrsOf fontType;
    default = { };
    description = "Collection of fonts metadata";
  };

  config = {
    lib2.fonts = rec {
      mkFontMeta = name: { inherit name; };
      withSize = size: meta: meta // { inherit size; };
      mkFontMetaCollection = lib.mapAttrs (_: mkFontMeta);
      mkNerdFontMetaCollection = lib.concatMapAttrs (id: name: {
        "${id}-nf" = mkFontMeta "${name} Nerd Font";
        "${id}-nf-mono" = mkFontMeta "${name} Nerd Font Mono";
        "${id}-nf-propo" = mkFontMeta "${name} Nerd Font Propo";
      });
    };

    den = {
      schema.host.options.fonts =
        let
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
  };
}
