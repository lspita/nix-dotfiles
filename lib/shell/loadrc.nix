{ lib }:
# string: full shell rc
{ config, ... }: # set: config inputs
shell: # string: shell name
lib.strings.concatStringsSep "\n" (
  builtins.map (
    source: if builtins.isFunction source then source shell else source
  ) config.custom.shell.rc
)
