{
  lib,
  flakeInputs,
  root,
  ...
}:
path:
with flakeInputs;
lib.attrsets.collect builtins.isString (
  haumea.lib.load {
    src = path;
    loader = haumea.lib.loaders.path;
  }
)
