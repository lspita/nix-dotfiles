{ root }:
# string: full path of asset
inputs: # set: config inputs
path: # string: relative path to the asset
"${root.dotfiles.dotPath inputs "assets"}/${path}"
