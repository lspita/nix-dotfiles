{ root, super }:
config: path: module:
super.mkModule config path (
  module
  // {
    enable = "enableDefaults";
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
