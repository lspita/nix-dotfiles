{ hostInfo, ... }:
{
  dotfilesHome = "nix-dotfiles"; # string: location of this repo relative to the user home
  backupFileExtension = "bkp"; # string: file extension to use for home-manager backups
  wallpaper = "desert-mountains"; # string?: wallpaper from `assets/wallpapers`
  user = {
    username = "lspita"; # string: short-form name
    fullname = "Ludovico Spitaleri"; # string: long-form name
    email = "ludovico.spitaleri@gmail.com"; # string?: user email (e.g. for git config)
    image = "clank"; # string?: user image from `assets/profiles`
    shell = pkgs: pkgs.bash; # fn(pkgs) -> pkg?: shell package to use for the user
  };
  nixpkgs.config =
    # set?: nixpkgs config (using flakes, you need to provide the nixpkgs config before the modules)
    {
      allowUnfree = true;
      android_sdk.accept_license = true;
      cudaSupport = hostInfo.graphics == "nvidia";
    };
  fonts =
    let
      size = 11;
    in
    {
      packages = # fn(pkgs) -> list[pkg]?: font packages to install
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
      normal = # font?: default font (interface, documents, ...)
        {
          inherit size;
          name = "NotoSans Nerd Font";
        };
      monospace = # font?: monospace font (terminal, editor, ...)
        {
          inherit size;
          name = "FiraMono Nerd Font";
        };
    };
  linux = {
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
        # { [string] = string }?: extra locales (en_IE is the most similar to EU english)
        {
          LC_ADDRESS = "it_IT.UTF-8";
          LC_IDENTIFICATION = "it_IT.UTF-8";
          LC_MEASUREMENT = "en_IE.UTF-8";
          LC_MONETARY = "en_IE.UTF-8";
          LC_NAME = "it_IT.UTF-8";
          LC_NUMERIC = "en_IE.UTF-8";
          LC_PAPER = "it_IT.UTF-8";
          LC_TELEPHONE = "it_IT.UTF-8";
          LC_TIME = "en_IE.UTF-8";
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
      terminal = # app?: default terminal app
        {
          desktop = "kitty.desktop";
          program = "kitty";
        };
      browser = # app?: default browser
        {
          desktop = "firefox.desktop";
          program = "firefox";
        };
      fileManager = null; # app?: default file manager
      editor = # app?: default text editor
        {
          desktop = "dev.zed.Zed.desktop";
          program = "zeditor";
        };
      terminalEditor = "nano"; # program: editor to use from terminal
      music = # app?: default music player (for audio files, set `audio`)
        {
          desktop = "spotify.desktop";
          program = "spotify";
        };
      mail = browser; # app?: default mail client
      pdf = null; # app?: default pdf viewer
      image = null; # app?: default image viewer
      audio = null; # app?: default audio player
      video = null; # app?: default video player
    };
  };
}
