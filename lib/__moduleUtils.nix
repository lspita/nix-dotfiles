{ lib, ... }:
{
  modulePath = path: [ "modules" ] ++ path;
  moduleName = modulePath: lib.concatStringsSep "." modulePath;
}
