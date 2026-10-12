{ config, lib, ... }: {
  options.lib2 = lib.mkOption {
    type = lib.types.attrs;
    default = { };
    description = "Custom library functions";
  };

  config._module.args.lib2 = config.lib2;
}
