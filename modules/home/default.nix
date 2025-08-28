{ customLib, ... }:
{
  imports = customLib.scanPaths ./.;

  home.stateVersion = "25.05"; # do not touch
}
