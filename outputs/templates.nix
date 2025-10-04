{ flakePath, ... }:
let
  root = flakePath "templates";
in
{
  templates = builtins.foldl' (
    result: path:
    result
    // {
      ${path} = {
        description = "${path}"; # description is required
        path = "${root}/${path}";
      };
    }
  ) { } (builtins.attrNames (builtins.readDir root));
}
