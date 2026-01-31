{
  dotfilesHome = "nix-dotfiles"; # string: location of this repo relative to the user home
  backupFileExtension = "bkp"; # string: file extension to use for home-manager backups
  wallpaper = "palette-gray"; # string | null: wallpaper from `assets/wallpapers`
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
      languages =
        # list[string]: used languages (e.g. for spellcheck)
        [
          "en_US"
          "en_GB"
          "it_IT"
        ];
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
        <program>: string = program name to use from cli
        <app>:
          desktop = desktop: desktop file for gui app
          program = program: program name to use from cli

        set to null to not override

        You can check available desktop files
        - system: ls /run/current-system/sw/share/applications/
        - user: ls /etc/profiles/per-user/$USER/share/applications/
      */
      terminal = null; # app | null: default terminal app
      browser = # app | null: default browser
        {
          desktop = "firefox.desktop";
          program = "firefox";
        };
      fileManager = null; # app | null: default file manager
      editor = # app | null: default text editor
        {
          desktop = "dev.zed.Zed.desktop";
          program = "zeditor";
        };
      terminalEditor = "nano"; # program: editor to use from terminal
      music = # app | null: default music player (for audio files, set `audio`)
        {
          desktop = "spotify.desktop";
          program = "spotify";
        };
      mail = browser; # app | null: default mail client
      pdf = null; # app | null: default pdf viewer
      image = null; # app | null: default image viewer
      audio = null; # app | null: default audio player
      video = null; # app | null: default video player
    };
  };
}
