{
  flake,
  lib,
  lib2,
  ...
}:
{
  options.flake.wallpapers = lib.mkOption {
    type = lib.types.attrs;
    default = { };
    description = "Wallpapers collection";
  };

  config = {
    den.schema.host.options.wallpaper = lib.mkOption {
      type = with lib.types; nullOr (enum (builtins.attrNames assets.wallpapers));
      default = null;
      description = "Wallpaper to use";
    };

    flake.lib.wallpapers = {
      selected = host: lib2.optionals.fmapNull (w: flake.wallpapers.${w}) host.wallpaper;

      wallpaperTypeValue =
        wallpaperOrType:
        { light-dark, regular }@options:
        let
          type = if builtins.isAttrs wallpaperOrType then wallpaperOrType.type else wallpaperOrType;
        in
        options.${type};
    };
  };
}
