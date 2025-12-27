{ lib }:
/*
  Trace the value given and return it
  any: same value passed as `value`
*/
traceOrOptions:
/*
  {
    message = string: trace message
    map = fn(any) -> any = value mapping function
    pred: fn(any) -> bool = trace predicate
  } |
  string: trace message
*/
value: # any: value to trace and return
let
  message = traceOrOptions.message or traceOrOptions;
  mapfn = traceOrOptions.mapfn or lib.id;
  predicatefn = traceOrOptions.predicatefn or (_: true);
in
if predicatefn value then
  builtins.trace "${message} -- ${builtins.toJSON (mapfn value)}" value
else
  value
