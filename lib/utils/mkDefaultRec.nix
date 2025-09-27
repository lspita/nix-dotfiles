{ lib }: value: lib.attrsets.mapAttrsRecursive (_: value: lib.mkDefault value) value
