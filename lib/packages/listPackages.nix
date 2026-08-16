{ lib }:
# list[pkg]: all packages in a group
packageGroup: # set: packages group
builtins.filter (pkg: lib.isDerivation pkg) (builtins.attrValues packageGroup)
