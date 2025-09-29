{ lib }:
root:
lib.strings.concatStringsSep "\n" (
  lib.attrsets.foldlAttrs (
    result: name: body:
    result
    ++ [
      ''
        ${name}() {
          ${body}
        }
      ''
    ]
  ) [ ] root.shell.functions
)
