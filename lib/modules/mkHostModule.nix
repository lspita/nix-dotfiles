{ super, hostDirRel }:
inputs: path: module:
super.mkModule inputs path (
  module
  // {
    enable = true;
    root = [ "hostModules" ];
    dirPath = hostDirRel;
  }
)
