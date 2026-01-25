{ lib, ... }:
default: # pkg | null: default package to use
name: # string: name to use in the description
lib.mkOption {
  inherit default;
  type = with lib.types; nullOr package;
  description = "Package to use for ${name}";
}
