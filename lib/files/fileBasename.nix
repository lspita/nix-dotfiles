{ lib }:
# string: file name without last extensions
filename: # string: file name
lib.strings.join "." (lib.lists.dropEnd 1 (lib.strings.splitString "." filename))
