{ lib, flakeInputs, ... }:
# list[path]: list of all files inside `path` recursively
path: # path: dir to list
with flakeInputs;
lib.attrsets.collect builtins.isString (
  haumea.lib.load {
    src = path;
    loader = haumea.lib.loaders.path;
  }
)
