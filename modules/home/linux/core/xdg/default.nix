{
  config,
  lib,
  vars,
  ...
}@inputs:
with lib.custom;
modules.mkModule inputs ./. {
  options = {
    openAlias = modules.mkEnableOption true "open alias";
  };
  config =
    { self, ... }:
    {
      # https://github.com/ryan4yin/nix-config/blob/main/home/linux/gui/base/xdg.nix
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

        }
        // (
          if vars.linux.wsl then
            { }
          else
            with vars.linux.defaultApps;
            {
              terminal-exec = {
                enable = true;
              }
              // (optionals.ifNotNull { } {
                settings.default = [ terminal.desktop ];
              } terminal);

              autostart = {
                enable = true;
              };

              mimeApps = {
                enable = true;
                defaultApplications =
                  let
                    setAssociations =
                      app: mimetypes:
                      optionals.ifNotNull { } (builtins.listToAttrs (
                        map (mime: lib.attrsets.nameValuePair mime app.desktop) mimetypes
                      )) app;
                  in
                  (builtins.foldl' (result: current: result // current) { } [
                    (setAssociations browser [
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
                    (setAssociations editor [
                      "text/plain"
                      "text/markdown"
                      "text/*"
                      "application/json"
                      "application/xml"
                      "application/x-yaml"
                    ])
                    (setAssociations fileManager [ "inode/directory" ])
                    (setAssociations pdf [ "application/pdf" ])
                    (setAssociations mail [ "x-scheme-handler/mailto" ])
                    (setAssociations image [
                      "image/jpeg"
                      "image/png"
                      "image/gif"
                      "image/webp"
                      "image/tiff"
                      "image/x-tga"
                      "image/vnd-ms.dds"
                      "image/x-dds"
                      "image/bmp"
                      "image/vnd.microsoft.icon"
                      "image/vnd.radiance"
                      "image/x-exr"
                      "image/x-portable-bitmap"
                      "image/x-portable-graymap"
                      "image/x-portable-pixmap"
                      "image/x-portable-anymap"
                      "image/x-qoi"
                      "image/qoi"
                      "image/svg+xml"
                      "image/svg+xml-compressed"
                      "image/avif"
                      "image/heic"
                      "image/jxl"
                      "image/*"
                    ])
                    (setAssociations audio [
                      "audio/mpeg"
                      "audio/wav"
                      "audio/x-aac"
                      "audio/x-aiff"
                      "audio/x-ape"
                      "audio/x-flac"
                      "audio/x-m4a"
                      "audio/x-m4b"
                      "audio/x-mp1"
                      "audio/x-mp2"
                      "audio/x-mp3"
                      "audio/x-mpg"
                      "audio/x-mpeg"
                      "audio/x-mpegurl"
                      "audio/x-opus+ogg"
                      "audio/x-pn-aiff"
                      "audio/x-pn-au"
                      "audio/x-pn-wav"
                      "audio/x-speex"
                      "audio/x-vorbis"
                      "audio/x-vorbis+ogg"
                      "audio/x-wavpack"
                      "audio/*"
                    ])
                    (setAssociations video [
                      "video/3gp"
                      "video/3gpp"
                      "video/3gpp2"
                      "video/dv"
                      "video/divx"
                      "video/fli"
                      "video/flv"
                      "video/mp2t"
                      "video/mp4"
                      "video/mp4v-es"
                      "video/mpeg"
                      "video/mpeg-system"
                      "video/msvideo"
                      "video/ogg"
                      "video/quicktime"
                      "video/vivo"
                      "video/vnd.avi"
                      "video/vnd.divx"
                      "video/vnd.rn-realvideo"
                      "video/vnd.vivo"
                      "video/webm"
                      "video/x-anim"
                      "video/x-avi"
                      "video/x-flc"
                      "video/x-fli"
                      "video/x-flic"
                      "video/x-flv"
                      "video/x-m4v"
                      "video/x-matroska"
                      "video/x-mjpeg"
                      "video/x-mpeg"
                      "video/x-mpeg2"
                      "video/x-ms-asf"
                      "video/x-ms-asf-plugin"
                      "video/x-ms-asx"
                      "video/x-msvideo"
                      "video/x-ms-wm"
                      "video/x-ms-wmv"
                      "video/x-ms-wmx"
                      "video/x-ms-wvx"
                      "video/x-nsv"
                      "video/x-ogm+ogg"
                      "video/x-theora"
                      "video/x-theora+ogg"
                      "video/x-totem-stream"
                      "video/*"
                    ])
                  ]);
              };
            }
        );
      home = {
        file.${config.xdg.userDirs.templates}.source = ./templates;
      }
      // (
        if self.openAlias then
          {
            shellAliases.open = "xdg-open";
          }
        else
          { }
      );
    };
}
