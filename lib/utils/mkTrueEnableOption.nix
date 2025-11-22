{ lib }:
# option: `lib.mkEnableOption` but enabled by default
name: # string: option name
lib.mkOption {
  type = lib.types.bool;
  default = true;
  description = "Whether to enable ${name}.";
}
