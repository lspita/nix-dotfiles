{ super }:
# set: module for enabling a category defaults
inputs: # set: config inputs
path: # path: path to module (or dir if it is default.nix)
module: # set: module config
super.mkModule inputs path (
  module
  // {
    enableOption = "enableDefaults";
  }
)
