{ pkgs, ... }:
{
  imports = [
    ./keyboard-remap.nix
    ./gnome/touchpad-resize.nix
  ];

  custom = {
    enableDefaults = true;
    nixos = {
      core.enableDefaults = true;
      login.gdm.enable = true;
      desktop = {
        enableDefaults = true;
        gnome = {
          enable = true;
          excludePackages = with pkgs; [ gnome-console ]; # use kitty instead
        };
      };
      virtualisation =
        let
          autoPrune = {
            enable = true;
          };
        in
        {
          docker = {
            inherit autoPrune;
            enable = true;
          };
          podman = {
            inherit autoPrune;
            enable = true;
          };
        };
    };
  };
}
