{ den, lib, ... }: {
  den.aspects.desktop.plasma = {
    includes = with den.aspects.desktop.plasma; [ accounts-integrations ];

    nixos = { config, host, pkgs, ... }: {
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
  };
}
