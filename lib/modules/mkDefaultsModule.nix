{ root, super }:
# set: module for enabling a category defaults
inputs: # set: config inputs
path: # path: path to module (or dir if it is default.nix)
module:
/*
  set: module config. If it is a function, it gets an extra input
  setDefaultSubconfig = fn(any) -> set: function to set submodules default settings
*/
super.mkModule inputs path (
  module
  // {
    enableOption = "enableDefaults";
    config =
      { setSubconfig, ... }@inputs:
      if builtins.isFunction module.config then
        module.config (
          inputs // { setDefaultSubconfig = value: setSubconfig (root.utils.mkDefaultRec value); }
        )
      else
        module.config;
  }
)
