{ super }:
# set: module for enabling a category defaults
inputs: # set: config inputs
modulePath: # path: path to module (or dir if it is default.nix)
module: # set: module config
super.mkModule inputs modulePath (
  module
  // {
    enableOption = "enableDefaults";
  }
)
