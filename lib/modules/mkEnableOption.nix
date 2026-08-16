{ lib }:
# option: `lib.mkEnableOption` but with custom default value
default: # bool: default option value
name: # string: option name
lib.mkOption {
  type = lib.types.bool;
  default = default;
  description = "Whether to enable ${name}.";
}
