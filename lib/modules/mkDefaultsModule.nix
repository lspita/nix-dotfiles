{ root, super }:
inputs: path: module:
super.mkModule inputs path (
  module
  // {
    enableOption = "enableDefaults";
    config =
      { setSubconfig, ... }@inputs:
      if builtins.isFunction module.config then
        module.config (
          inputs // { setDefaultModules = value: setSubconfig (root.utils.mkDefaultRec value); }
        )
      else
        module.config;
  }
)
