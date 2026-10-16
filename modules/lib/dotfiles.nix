{
  lib2.dotfiles = {
    homeDir =
      config: user:
      if config ? home then config.home.homeDirectory else config.users.users.${user.userName}.home;
  };
}
