{
  config,
  lib,
  lib2,
  ...
}:
{
  options.wallpapers = lib.mkOption {
    type = lib.types.attrsOf (lib2.images.imageType { });
    default = { };
    description = "Wallpapers collection";
  };

  config = {
    _module.args.wallpapers = config.wallpapers;

    den.schema.host.options.wallpaper = lib.mkOption {
      type = with lib.types; nullOr (enum (builtins.attrNames config.wallpapers));
      default = null;
      description = "Wallpaper to use";
    };

    lib2.wallpapers = {
      selected = host: lib2.optionals.fmapNull (w: config.wallpapers.${w}) host.wallpaper;
    };
  };
}
