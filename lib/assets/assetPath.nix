{ root }:
# string: full path of asset
inputs: # set: config inputs
assetPath: # string: relative path to the asset
"${root.dotfiles.dotPath inputs "assets"}/${assetPath}"
