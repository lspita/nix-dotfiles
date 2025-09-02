{
  dotfilesHome = "nix-dotfiles"; # location of dotfiles in the user home
  overrideHostname = true;
  stateVersion = "25.05";
  backupFileExtension = "backup";
  user = {
    username = "lspita";
    fullname = "Ludovico Spitaleri";
    email = "ludovico.spitaleri@gmail.com"; # used for some configurations (e.g. git)
  };
  defaultApps = {
    # not the gui apps, used only for the enviroment variables. see `modules/home/core/default-apps.nix`
    browser = "firefox";
    editor = "nano";
  };
  nix = {
    cleaning = {
      frequency = "weekly";
      deleteOlderThan = "7d";
      maxGenerations = 5;
    };
    pkgs = {
      allowUnfree = true;
    };
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
}
