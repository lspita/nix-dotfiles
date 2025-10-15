{ super, hostDirRel }:
inputs: path: module:
super.mkModule inputs path (
  module
  // {
    enable = module.enable or true;
    root = [ "hostModules" ];
    dirPath = hostDirRel;
  }
)
