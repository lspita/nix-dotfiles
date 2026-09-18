{ flake, lib, ... }: {
  options.flake.lib = lib.mkOption {
    type = lib.types.attrs;
    default = { };
    description = "Custom library functions";
  };

  config._module.args.lib2 = flake.lib;
}
