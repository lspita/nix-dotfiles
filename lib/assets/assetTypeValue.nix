_:
# any: different value based on the asset type
assetOrType: # set | string: asset or type
{
  light-dark, # any: value if asset type is "light-dark"
  regular, # any: value if asset type is "regular"
}@options:
let
  type = if builtins.isAttrs assetOrType then assetOrType.type else assetOrType;
in
options.${type}
