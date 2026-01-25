{ config, lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./. {
  config = {
    xdg =
      let
        homeDir = dotfiles.homeDir inputs;
      in
      {
        enable = true;
        cacheHome = "${homeDir}/.cache";
        configHome = "${homeDir}/.config";
        dataHome = "${homeDir}/.local/share";
        stateHome = "${homeDir}/.local/state";

        userDirs = {
          enable = true;
          createDirectories = true;
          desktop = "${homeDir}/Desktop";
          documents = "${homeDir}/Documents";
          download = "${homeDir}/Downloads";
          music = "${homeDir}/Music";
          pictures = "${homeDir}/Pictures";
          publicShare = "${homeDir}/Public";
          templates = "${homeDir}/Templates";
          videos = "${homeDir}/Videos";
        };
      };
    home.file.${config.xdg.userDirs.templates}.source = ./templates;
  };
}
