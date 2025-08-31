{
  dotfilesHome = "nix-dotfiles"; # location of dotfiles in the user home
  overrideHostname = true;
  stateVersion = "25.05";
  user = {
    username = "lspita";
    fullname = "Ludovico Spitaleri";
    email = "ludovico.spitaleri@gmail.com"; # used for some configurations (e.g. git)
  };
  editor = "nano";
  nixpkgs = {
    allowUnfree = true;
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
