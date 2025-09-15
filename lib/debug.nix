{ }:
{
  trace,
  map ? (a: a),
  condition ? (_: true),
}:
value:
if condition value then builtins.trace "${trace} -- ${builtins.toJSON (map value)}" value else value
