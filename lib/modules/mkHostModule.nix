{ super, hostDirRel }:
# set: module for host-specific settings
inputs: # set: config inputs
path: # path: path to module (or dir if it is default.nix)
module: # set: module settings
super.mkModule inputs path (
  module
  // {
    enable = module.enable or true;
    root = [ "hostModules" ];
    dirPath = hostDirRel;
  }
)
