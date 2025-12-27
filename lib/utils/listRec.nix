{ lib, flakeInputs, ... }:
# list[path]: list of all files inside `path` recursively
dirPath: # path: directory to list
with flakeInputs;
lib.attrsets.collect builtins.isString (
  haumea.lib.load {
    src = dirPath;
    loader = haumea.lib.loaders.path;
  }
)
