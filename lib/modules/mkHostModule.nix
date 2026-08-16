{ super, hostDirRel }:
# set: module for host-specific settings
inputs: # set: config inputs
modulePath: # path: path to module (or dir if it is default.nix)
module: # set: module settings
super.mkModule inputs modulePath (
  module
  // {
    root = [ "hostModules" ];
    dirPath = hostDirRel;
  }
)
