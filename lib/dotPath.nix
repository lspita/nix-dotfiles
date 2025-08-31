{ vars, ... }: config: path: "${config.home.homeDirectory}/${vars.dotfilesHome}/${path}"
