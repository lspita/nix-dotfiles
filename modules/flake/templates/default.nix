{ lib, ... }:
let
  templatesRoot = ./_templates;
in
{
  flake.templates =
    builtins.readDir templatesRoot
    |> lib.filterAttrs (_: t: t == "directory")
    |> builtins.attrNames
    |> builtins.foldl' (
      acc: name:
      acc
      // {
        ${name} = {
          description = "${name} devshell";
          path = lib.path.append templatesRoot name;
        };
      }
    ) { };
}
