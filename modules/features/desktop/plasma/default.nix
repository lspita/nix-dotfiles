{
  den,
  lib,
  lib2,
  inputs,
  ...
}:
{
  den.aspects.desktop.plasma = {
    includes = with den.aspects.desktop.plasma; [
      xdg
      accounts-integrations
      programs
    ];

    nixos =
      {
        config,
        host,
        pkgs,
        ...
      }:
      {
        # https://wiki.nixos.org/wiki/KDE
        # https://nixos.wiki/wiki/KDE
        services.desktopManager.plasma6.enable = true;
        environment = with pkgs.kdePackages; {
          systemPackages = [
            # https://apps.kde.org/
            kcalc
            kcharselect
            kclock
            kcolorchooser
            kolourpaint
            ksystemlog
            isoimagewriter
            partitionmanager
            filelight
            kamoso
            krecorder
            kde-gtk-config
          ]
          ++ (lib.optional config.services.displayManager.sddm.enable sddm-kcm); # sddm settings integration
          plasma6.excludePackages = lib.optionals (!isNull host.programs.terminal) [
            konsole
            dolphin
          ];
        };
      };

    homeManager = {
      imports = [ inputs.plasma-manager.homeModules.plasma-manager ];
      config.programs.plasma.enable = true;
    };

    xdg = {
      includes = with den.aspects; [ system.xdg ];
      homeManager = { pkgs, ... }: {
        features.system.xdg.portal.packages = with pkgs.kdePackages; [
          xdg-desktop-portal-kde
        ];
      };
    };

    accounts-integrations.nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs.kdePackages; [
        # online accounts integration
        kaccounts-integration
        kaccounts-providers
        signond
        signon-kwallet-extension
        kio-gdrive
      ];
    };

    settings.homeManager = { host, ... }: {
      programs.plasma = {
        overrideConfig = true;
        workspace = {
          enableMiddleClickPaste = false;
          splashScreen.theme = "org.kde.breeze.desktop";
        };
        input.keyboard = {
          layouts = [ { layout = host.locale.keyboard; } ];
          numlockOnStartup = "on";
        };
        session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
        kwin = {
          virtualDesktops = {
            number = 5;
            rows = 1;
          };
          cornerBarrier = false;
          edgeBarrier = 0;
          effects = {
            blur = {
              enable = true;
              strength = 8;
              noiseStrength = 3;
            };
            desktopSwitching.navigationWrapping = true;
            hideCursor = {
              enable = true;
              hideOnInactivity = 5;
              hideOnTyping = true;
            };
            shakeCursor.enable = true;
            translucency.enable = false;
          };
        };
        searchPlugins.webSearchKeywords.default = "google";
        configFile = {
          kded5rc.Module-browserintegrationreminder.autoload = false; # disable browser integration alert in system tray
          kwinrc = {
            Effect-overview = {
              FilterWindows = true; # false to make search in overview ignore windows
              BorderActivate = 9;
            };
            ElectricBorders = {
              TopLeft = "";
              Top = "";
              TopRight = "";
              Right = "";
              BottomRight = "";
              Bottom = "";
              BottomLeft = "";
              Left = "";
            };
          };
          kdeglobals.General =
            let
              plasmaTerminal = lib2.plasma.programs.terminal.meta;
              terminal = lib2.optionals.getOrDefault plasmaTerminal host.programs.terminal;
            in
            {
              TerminalApplication = terminal.exec;
            }
            // (lib.optionalAttrs (!isNull terminal.desktop) {
              TerminalService = terminal.desktop;
            });
        };
      };
    };
  };
}
