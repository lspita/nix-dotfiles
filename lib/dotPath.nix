{ vars }:
config: path:
"${
  config.home.homeDirectory or config.users.users.${vars.user.username}.home
}/${vars.dotfilesHome}/${path}"
