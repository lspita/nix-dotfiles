{ lib }:
{ config, ... }:
shell:
lib.strings.concatStringsSep "\n" (
  builtins.map (
    source: if builtins.isFunction source then source shell else source
  ) config.custom.shell.rc
)
