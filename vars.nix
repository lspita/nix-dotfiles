{
  dotfilesHome = "nix-dotfiles"; # location of dotfiles in the user home
  backupFileExtension = "bkp";
  wallpaper = "moon";
  user = {
    username = "lspita";
    fullname = "Ludovico Spitaleri";
    email = "ludovico.spitaleri@gmail.com"; # used for some configurations (e.g. git)
    image = "clank";
  };

  nix.allowUnfree = true;

  shell = pkgs: pkgs.bash;
  fonts =
    let
      size = 11;
    in
    {
      packages =
        pkgs: with pkgs; [
          nerd-fonts.noto
          noto-fonts
          nerd-fonts.jetbrains-mono
        ];
      normal = {
        inherit size;
        name = "NotoSans Nerd Font";
      };
      monospace = {
        inherit size;
        name = "NotoMono Nerd Font";
      };
    };
  linux = {
    defaultApps = rec {
      # Some app types need both desktop and program definitions.
      # - desktop: desktop file for gui app
      # - program: use from cli (but can be a gui app)
      #
      # You can check available desktop files
      # - system: ls /run/current-system/sw/share/applications/
      # - user: ls /etc/profiles/per-user/$USER/share/applications/
      terminal = {
        desktop = "org.gnome.Console.desktop";
        program = "kgx";
      };
      browser = {
        desktop = "firefox.desktop";
        program = "firefox";
      };
      editor = {
        desktop = "code.desktop";
        program = "nano";
      };
      fileManager = "org.gnome.Nautilus.desktop";
      music = "spotify.desktop";
      pdf = browser.desktop;
      mail = browser.desktop;
      image = "org.gnome.Loupe.desktop";
      audio = "org.gnome.Decibels.desktop";
      video = "org.gnome.Totem.desktop";
    };
    locale = {
      timeZone = "Europe/Rome";
      keyboard = "it";
      default = "en_US.UTF-8";
      extraSettings = {
        LC_ADDRESS = "it_IT.UTF-8";
        LC_IDENTIFICATION = "it_IT.UTF-8";
        LC_MEASUREMENT = "it_IT.UTF-8";
        LC_MONETARY = "it_IT.UTF-8";
        LC_NAME = "it_IT.UTF-8";
        LC_NUMERIC = "it_IT.UTF-8";
        LC_PAPER = "it_IT.UTF-8";
        LC_TELEPHONE = "it_IT.UTF-8";
        LC_TIME = "it_IT.UTF-8";
      };
    };
  };
}
