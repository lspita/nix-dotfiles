{ lib }:
options: value:
let
  trace = options.trace or options;
  map = options.map or lib.id;
  pred = options.pred or (_: true);
in
if pred value then builtins.trace "${trace} -- ${builtins.toJSON (map value)}" value else value
