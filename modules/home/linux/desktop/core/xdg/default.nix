{
  config,
  lib,
  vars,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "linux"
    "desktop"
    "core"
    "xdg"
  ];
  mkConfig =
    { ... }:
    {
      # https://github.com/ryan4yin/nix-config/blob/main/home/linux/gui/base/xdg.nix
      xdg = with vars.linux.defaultApps; {
        enable = true;
        terminal-exec = {
          enable = true;
          settings.default = [ terminal.desktop ];
        };
        cacheHome = "${config.home.homeDirectory}/.cache";
        configHome = "${config.home.homeDirectory}/.config";
        dataHome = "${config.home.homeDirectory}/.local/share";
        stateHome = "${config.home.homeDirectory}/.local/state";

        userDirs = {
          enable = true;
          createDirectories = true;
          desktop = "${config.home.homeDirectory}/Desktop";
          documents = "${config.home.homeDirectory}/Documents";
          download = "${config.home.homeDirectory}/Downloads";
          music = "${config.home.homeDirectory}/Music";
          pictures = "${config.home.homeDirectory}/Pictures";
          publicShare = "${config.home.homeDirectory}/Public";
          templates = "${config.home.homeDirectory}/Templates";
          videos = "${config.home.homeDirectory}/Videos";
        };

        autostart = {
          enable = true;
          readOnly = false; # for now, allow autostart
        };

        mimeApps = {
          enable = true;
          defaultApplications =
            let
              setAssociations =
                app: mimetypes:
                builtins.listToAttrs (builtins.map (mime: lib.attrsets.nameValuePair mime app) mimetypes);
            in
            (builtins.foldl' (result: current: result // current) { } [
              (setAssociations browser.desktop [
                "text/html"
                "application/xhtml+xml"
                "application/xhtml_xml"
                "application/rdf+xml"
                "application/rss+xml"
                "application/x-extension-htm"
                "application/x-extension-html"
                "application/x-extension-shtml"
                "application/x-extension-xht"
                "application/x-extension-xhtml"
                "x-scheme-handler/http"
                "x-scheme-handler/https"
              ])
              (setAssociations editor.desktop [
                "text/plain" # make plasma recognize it
                "text/markdown"
                "text/*"
                "application/json"
                "application/xml"
                "application/x-yaml"
              ])
              (setAssociations fileManager [ "inode/directory" ])
              (setAssociations pdf [ "application/pdf" ])
              (setAssociations mail [ "x-scheme-handler/mailto" ])
              (setAssociations image [ "image/*" ])
              (setAssociations audio [ "audio/*" ])
              (setAssociations video [ "video/*" ])
            ]);
        };
      };
      home = {
        shellAliases.open = "xdg-open";
        file.${config.xdg.userDirs.templates}.source = ./templates;
      };
    };
}
