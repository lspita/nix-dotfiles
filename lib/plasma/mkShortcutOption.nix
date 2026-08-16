{ lib }:
# option: option to get a plasma shortcut
{
  default ? null, # null|string|list[string]: default shortcut
}:
name: # string: shortcut name
lib.mkOption {
  type = with lib.types; either (nullOr str) (listOf str);
  default = default;
  description = "Shortcut to ${name}";
}
