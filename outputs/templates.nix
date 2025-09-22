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
        path = "${root}/${path}";
      };
    }
  ) { } (builtins.attrNames (builtins.readDir root));
}
