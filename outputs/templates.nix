{ listDir, flakePath, ... }:
let
  root = flakePath "templates";
in
{
  templates =
    builtins.foldl'
      (
        result: path:
        result
        // {
          ${path} = {
            description = "${path}"; # description is required
            path = "${root}/${path}";
          };
        }
      )
      { }
      (listDir {
        path = root;
        filter = (_: type: type == "directory");
      });
}
