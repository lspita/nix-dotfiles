{ customLib, pkgs, ... }:
{
  imports = customLib.scanPaths ./.;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    zed-editor
    nixd
    nil
    firefox
    git
  ];

  system.stateVersion = "25.05"; # do not touch
}
