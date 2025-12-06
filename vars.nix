{
  dotfilesHome = "nix-dotfiles"; # string: location of this repo relative to the user home
  backupFileExtension = "bkp"; # string: file extension to use for home-manager backups
  wallpaper = "moon"; # string | null: wallpaper from `assets/wallpapers`
  user = {
    username = "lspita"; # string: short-form name
    fullname = "Ludovico Spitaleri"; # string: long-form name
    email = "ludovico.spitaleri@gmail.com"; # string | null: user email (e.g. for git config)
    image = "clank"; # string | null: user image from `assets/profiles`
    shell = pkgs: pkgs.bash; # fn(pkgs) -> pkg | null: shell package to use for the user
  };
  nix.allowUnfree = true; # bool: if to allow nix unfree software
  fonts =
    let
      size = 11;
    in
    {
      packages = # fn(pkgs) -> list[pkg] | null: font packages to install
        pkgs: with pkgs; [
          noto-fonts
          nerd-fonts.noto
          nerd-fonts.jetbrains-mono
          nerd-fonts.fira-code
          nerd-fonts.fira-mono
        ];
      /*
        <font>:
          size = int: size of the font
          name = string: name of the font
      */
      normal = # font | null: default font (interface, documents, ...)
        {
          inherit size;
          name = "NotoSans Nerd Font";
        };
      monospace = # font | null: monospace font (terminal, editor, ...)
        {
          inherit size;
          name = "FiraMono Nerd Font";
        };
    };
  linux = {
    wsl = false; # bool: if it is a wsl system
    locale = {
      timeZone = "Europe/Rome"; # string: system time zone
      keyboard = "it"; # string: keyboard layout
      default = "en_US.UTF-8"; # string: default locale
      extraSettings =
        # { [string] = string } | null: extra locales
        {
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
    defaultApps = rec {
      /*
        <desktop>: string = .desktop file of gui app
        <app>:
          desktop = <desktop> | null: desktop file for gui app
          program = string | null: program name to use from cli

        You can check available desktop files
        - system: ls /run/current-system/sw/share/applications/
        - user: ls /etc/profiles/per-user/$USER/share/applications/
      */
      terminal =
        # app: default terminal app
        {
          desktop = null;
          program = null;
        };
      browser = # app: default browser
        {
          desktop = "firefox.desktop";
          program = "firefox";
        };
      editor = # app: default text editor
        {
          desktop = "dev.zed.Zed.desktop";
          # desktop = "code.desktop";
          program = "nano";
        };
      fileManager = # app: default file manager
        {
          desktop = null;
          program = null;
        };
      music = "spotify.desktop"; # desktop | null: default music player (for audio files, set `audio`)
      mail = browser.desktop; # desktop | null: default mail client
      pdf = null; # desktop | null: default pdf viewer
      image = null; # desktop | null: default image viewer
      audio = null; # desktop | null: default audio player
      video = null; # desktop | null: default video player
    };
  };
}
