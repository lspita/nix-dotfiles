{ ... }:
{
  # https://wiki.nixos.org/wiki/Keyd
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          "leftshift+leftmeta+f23" = "rightmeta"; # copilot = rightmeta
        };
        altgr = {
          "l" = "102nd"; # altgr + l = < (and > with shift)
        };
      };
    };
  };

}
