{ ... }:
{
  imports = [
    ./home/plasma-touchpad.nix
  ];

  custom.modules = {
    core.enableDefaults = true;
    linux.desktop = {
      core.enableDefaults = true;
      plasma.enableDefaults = true;
    };
    pkgs.enable = true;
    security.bitwarden = {
      enable = true;
      sshAgent.enable = true;
    };
    shell = {
      enableDefaults = true;
      bash.enable = true;
    };
    editor.zed.enable = true;
  };
}
