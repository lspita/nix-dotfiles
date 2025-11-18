{
  dotfilesHome = "nix-dotfiles"; # location of dotfiles in the user home
  backupFileExtension = "bkp";
  wallpaper = "planet";
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
      # font packages to install
      packages =
        pkgs: with pkgs; [
          noto-fonts
          nerd-fonts.noto
          nerd-fonts.jetbrains-mono
          nerd-fonts.fira-code
          nerd-fonts.fira-mono
        ];
      # every font can either be null to not override or an attrset with name and size
      normal = {
        inherit size;
        name = "NotoSans Nerd Font";
      };
      monospace = {
        inherit size;
        name = "FiraMono Nerd Font";
      };
    };
  linux = rec {
    wsl = false;
    defaultApps =
      let
        noWSL = value: if wsl then null else value;
      in
      rec {
        # Some app types need both desktop and program definitions.
        # - desktop: desktop file for gui app
        # - program: use from cli (but can be a gui app)
        #
        # You can check available desktop files
        # - system: ls /run/current-system/sw/share/applications/
        # - user: ls /etc/profiles/per-user/$USER/share/applications/
        #
        # use null to leave unset
        terminal = {
          desktop = null;
          program = null;
        };
        browser = {
          desktop = noWSL "firefox.desktop";
          program = noWSL "firefox";
        };
        editor = {
          desktop = noWSL "dev.zed.Zed.desktop";
          program = "nano";
        };
        fileManager = null;
        music = noWSL "spotify.desktop";
        mail = browser.desktop;
        pdf = null;
        image = null;
        audio = null;
        video = null;
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
