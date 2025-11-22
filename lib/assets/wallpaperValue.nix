_: wallpaperOrType:
{
  light-dark,
  regular,
}@options:
let
  type = if builtins.isAttrs wallpaperOrType then wallpaperOrType.type else wallpaperOrType;
in
options.${type}
