{ lib }:
/*
  Trace the value given and return it
  any: same value passed as `value`
*/
traceOrOptions:
/*
  {
    trace = string: trace message
    map = fn(any) -> any = value mapping function
    pred: fn(any) -> bool = trace predicate
  } |
  string: trace message
*/
value: # any: value to trace and return
let
  trace = traceOrOptions.trace or traceOrOptions;
  map = traceOrOptions.map or lib.id;
  pred = traceOrOptions.pred or (_: true);
in
if pred value then builtins.trace "${trace} -- ${builtins.toJSON (map value)}" value else value
