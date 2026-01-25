{ lib, pkgs, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./. {
  config = {
    home.packages = with pkgs; [ socat ];
    custom.shell.rc = [
      # ssh agent bridge https://www.rebelpeon.com/bitwarden-ssh-agent-on-wsl2/
      ''
        if __win-command-exists npiperelay.exe; then
            source ${./ssh-agent-bridge.sh}
        else
            echo "npiperelay not found, ssh agent bridge disabled." >&2
            echo "Install it with \`winget install albertony.npiperelay\`" >&2
        fi
      ''
    ];
  };
}
