{ flake, lib, ... }: {
  options.flake.lib = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = { };
    description = "Custom library functions";
  };

  config._module.args.lib2 = flake.lib;
}
