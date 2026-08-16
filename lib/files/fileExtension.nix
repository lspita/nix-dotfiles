{ lib }:
# string: file last extension
filename: # string: file name
builtins.head (lib.lists.takeEnd 1 (lib.strings.splitString "." filename))
