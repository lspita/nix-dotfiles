{ super, vars }:
# set: wallpaper assets
inputs: # set: config inputs
let
  profiles = super.getAssets inputs "profiles";
  profile = vars.user.image;
in
if isNull profile || builtins.hasAttr profile profiles then
  profiles
else
  throw "Invalid profile selected: ${profile}"
