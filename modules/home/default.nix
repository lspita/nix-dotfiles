{ customLib, ... }:
{
  imports = customLib.scanPaths ./.;
  home.stateVersion = "25.05"; # Did you read the comment?
}
