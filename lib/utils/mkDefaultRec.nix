{ lib }:
# set: `value` but with all values as default options
value: # set: original set
lib.attrsets.mapAttrsRecursive (_: value: lib.mkDefault value) value
