{
  config,
  lib,
  lib2,
  ...
}:
{
  options.meta.assets.wallpapers = lib.mkOption {
    type = lib.types.attrsOf (lib2.images.imageType { });
    default = { };
    description = "Wallpapers collection";
  };

  config = {
    den.schema.host.options.wallpaper = lib.mkOption {
      type = with lib.types; nullOr (enum (builtins.attrNames config.assets.wallpapers));
      default = null;
      description = "Wallpaper to use";
    };

    lib2.assets.wallpapers = {
      selected = host: lib2.optionals.fmapNull (w: config.assets.wallpapers.${w}) host.wallpaper;
    };
  };
}
