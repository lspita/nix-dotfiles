{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./. {
  config =
    { path, ... }:
    let
      configDir = "zed";
    in
    {
      home = {
        # not programs.zed-editor to have the settings symlinked
        packages = with pkgs; [
          zed-editor
        ];
        shellAliases.zed = "zeditor";
      };
      xdg.configFile = {
        "${configDir}/settings.json".source = dotfiles.dotSymlink inputs "${path}/settings.json";
      };
    };
}
