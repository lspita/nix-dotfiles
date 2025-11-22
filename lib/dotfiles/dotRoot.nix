{ super, vars }:
# string: full path to this repo
inputs: # set: config inputs
"${super.homeDir inputs}/${vars.dotfilesHome}"
