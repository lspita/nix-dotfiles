{ listDir, flakePath, ... }:
let
  root = flakePath "templates";
in
{
  templates =
    builtins.foldl'
      (
        result: templatePath:
        result
        // {
          ${templatePath} = {
            description = "${templatePath}"; # description is required
            path = "${root}/${templatePath}";
          };
        }
      )
      { }
      (listDir {
        dirPath = root;
        filterfn = (_: type: type == "directory");
      });
}
