{ lib, ... }@inputs:
with lib.custom;
modules.mkHostModule inputs ./keyboardRemap.nix {
  config = {
    # https://wiki.nixos.org/wiki/Keyd
    # To watch events: nix-shell -p keyd --run "sudo keyd monitor"
    services.keyd = {
      enable = true;
      keyboards.default = {
        ids = [ "*" ];
        settings = {
          main = {
            "leftshift+leftmeta+f23" = "rightcontrol"; # copilot = right control
          };
          altgr = {
            "l" = "102nd"; # altgr + l = < (and > with shift)
          };
        };
      };
    };
  };
}
