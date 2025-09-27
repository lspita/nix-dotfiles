{ lib }:
name:
lib.mkOption {
  type = lib.types.bool;
  default = true;
  description = "Whether to enable ${name}.";
}
