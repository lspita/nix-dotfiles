{ flake, lib, ... }: {
  options.flake.assets = lib.mkOption {
    type = lib.types.attrs;
    default = { };
    description = "Assets collection";
  };

  config._module.args.assets = flake.assets;
}
