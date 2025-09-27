{ super }:
config: path: module:
super.mkModule config path (
  module
  // {
    enable = "enableDefaults";
  }
)
