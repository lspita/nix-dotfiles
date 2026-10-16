{
  den,
  lib,
  lib2,
  ...
}:
{
  den.aspects.system.xdg = {
    includes = with den.aspects.system.xdg; [
      autostart
      portal
      terminal-exec
      directories
      open-alias
      mimeapps
    ];

    nixos = { config, ... }: {
      # xdg.portal: since you installed Home Manager via its NixOS module and
      # 'home-manager.useUserPackages' is enabled, you need to add
      # environment.pathsToLink = [ `/share/applications` `/share/xdg-desktop-portal` ];
      # to your NixOS configuration so that the portal definitions and DE
      # provided configurations get linked.
      environment.pathsToLink = lib.optionals (config.home-manager.useUserPackages or false) [
        "/share/applications"
        "/share/xdg-desktop-portal"
      ];
    };

    homeManager.xdg.enable = true;

    autostart.homeManager.xdg.autostart.enable = true;

    portal.homeManager = { config, ... }: {
      options.features.system.xdg.portal = {
        packages = lib.mkOption {
          type = with lib.types; listOf package;
          default = [ ];
          description = "Portal packages to install";
        };
      };
      config.xdg.portal =
        let
          inherit (config.features.system.xdg.portal) packages;
        in
        {
          enable = true;
          configPackages = packages;
          extraPortals = packages;
          xdgOpenUsePortal = true;
        };
    };

    terminal-exec.homeManager = { host, ... }: {
      xdg.terminal-exec = {
        enable = true;
      }
      // (
        let
          inherit (host.programs) terminal;
        in
        lib.optionalAttrs (!isNull terminal && !isNull terminal.desktop) {
          settings.default = [ terminal.desktop ];
        }
      );
    };

    directories.homeManager = { config, user, ... }: {
      xdg =
        let
          homeDir = lib2.dotfiles.homeDir config user;
        in
        {
          cacheHome = "${homeDir}/.cache";
          configHome = "${homeDir}/.config";
          binHome = "${homeDir}/.local/bin";
          dataHome = "${homeDir}/.local/share";
          stateHome = "${homeDir}/.local/state";

          localBinInPath = true;
          userDirs = {
            enable = true;
            createDirectories = true;
            setSessionVariables = true;
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

    open-alias.homeManager.home.shellAliases = {
      open = "xdg-open";
    };

    mimeapps = { host, ... }: rec {
      homeManager.xdg.mimeApps.enable = true;

      mime-handler =
        program: mimetypes:
        let
          associations = lib.optionalAttrs (!isNull program && !isNull program.desktop) (
            builtins.foldl' (res: mime: res // { ${mime} = program.desktop; }) { } mimetypes
          );
        in
        {
          homeManager.xdg.mimeApps.defaultApplications = associations;
        };

      includes =
        let
          inherit (host) programs;
        in
        [
          (mime-handler programs.browser [
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
          (mime-handler programs.editor [
            "text/plain"
            "text/markdown"
            "text/*"
            "application/json"
            "application/xml"
            "application/x-yaml"
          ])
          (mime-handler programs.fileManager [ "inode/directory" ])
          (mime-handler programs.pdf [ "application/pdf" ])
          (mime-handler programs.mail [ "x-scheme-handler/mailto" ])
          (mime-handler programs.image [
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
          (mime-handler programs.audio [
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
          (mime-handler programs.video [
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
        ];
    };
  };
}
