{ lib, ... }: {
  options.lib2 = lib.mkOption {
    type = lib.types.attrs;
    default = { };
    description = "Custom library functions";
  };
}
