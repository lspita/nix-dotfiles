{ den, lib, lib2, ... }:
{
  den.aspects.system.xdg = {
    includes = with den.aspects.system.xdg; [
      autostart
      portal
      terminal-exec
      directories
      open-alias
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
  };
}
