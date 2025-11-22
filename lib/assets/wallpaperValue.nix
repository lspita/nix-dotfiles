_:
# any: different value based on the wallpaper type
wallpaperOrType: # set | string: wallpaper or type
{
  light-dark, # any: value if wallapaper type is "light-dark"
  regular, # any: value if wallpaper type is "regular"
}@options:
let
  type = if builtins.isAttrs wallpaperOrType then wallpaperOrType.type else wallpaperOrType;
in
options.${type}
