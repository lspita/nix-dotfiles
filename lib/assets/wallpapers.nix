{ super, vars }:
# set: wallpaper assets
inputs: # set: config inputs
let
  wallpapers = super.getAssets inputs "wallpapers";
  wallpaper = vars.wallpaper;
in
if isNull wallpaper || builtins.hasAttr wallpaper wallpapers then
  wallpapers
else
  throw "Invalid wallpaper selected: ${wallpaper}"
