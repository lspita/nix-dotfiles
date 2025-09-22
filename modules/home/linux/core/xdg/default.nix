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
      };
      home = {
        shellAliases.open = "xdg-open";
        file.${config.xdg.userDirs.templates}.source = ./templates;
      };
    };
}
