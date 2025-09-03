{
  config,
  customLib,
  vars,
  ...
}:
customLib.mkModule {
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
      xdg = {
        enable = true;
        terminal-exec.enable = true;
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

          extraConfig = {
            XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
          };
        };

        autostart = {
          enable = true;
          readOnly = false; # for now, allow autostart
        };

        # manage $XDG_CONFIG_HOME/mimeapps.list
        # xdg search all desktop entries from $XDG_DATA_DIRS, check it by command:
        #  echo $XDG_DATA_DIRS
        # the system-level desktop entries can be list by command:
        #   ls -l /run/current-system/sw/share/applications/
        # the user-level desktop entries can be list by command:
        #  ls /etc/profiles/per-user/$USER/share/applications/
        mimeApps = with vars.defaultApps; {
          enable = true;
          #   defaultApplications = {
          #     "application/json" = browser;
          #     "application/pdf" = pdf;

          #     "text/html" = browser;
          #     "text/xml" = browser;
          #     "text/plain" = editor.gui;
          #     "application/xml" = browser;
          #     "application/xhtml+xml" = browser;
          #     "application/xhtml_xml" = browser;
          #     "application/rdf+xml" = browser;
          #     "application/rss+xml" = browser;
          #     "application/x-extension-htm" = browser;
          #     "application/x-extension-html" = browser;
          #     "application/x-extension-shtml" = browser;
          #     "application/x-extension-xht" = browser;
          #     "application/x-extension-xhtml" = browser;
          #     "application/x-wine-extension-ini" = editor;

          #     # define default applications for some url schemes.
          #     "x-scheme-handler/about" = browser; # open `about:` url with `browser`
          #     "x-scheme-handler/ftp" = browser; # open `ftp:` url with `browser`
          #     "x-scheme-handler/http" = browser;
          #     "x-scheme-handler/https" = browser;

          #     # all other unknown schemes will be opened by this default application.
          #     "x-scheme-handler/unknown" = editor.gui;

          #     "audio/*" = [ "mpv.desktop" ];
          #     "video/*" = [ "mpv.desktop" ];
          #     "image/*" = [ "imv-dir.desktop" ];
          #     "image/gif" = [ "imv-dir.desktop" ];
          #     "image/jpeg" = [ "imv-dir.desktop" ];
          #     "image/png" = [ "imv-dir.desktop" ];
          #     "image/webp" = [ "imv-dir.desktop" ];

          #     "inode/directory" = [ "yazi.desktop" ];
          #   };
        };
      };
    };
}
