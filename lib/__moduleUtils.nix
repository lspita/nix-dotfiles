{ lib }:
{
  modulePath =
    path:
    [
      "custom"
      "modules"
    ]
    ++ path;
  moduleName = modulePath: lib.concatStringsSep "." modulePath;
}
