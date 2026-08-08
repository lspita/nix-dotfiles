{ den, ... }: {
  den = {
    hosts.x86_64-linux.clank = {
      stateVersion = "26.11";
      graphics = "intel";
      users.lspita = { };
    };
    aspects.clank = with den.ful; {
      includes = [
        boot.systemd-boot
        nix.settings
      ];

      os.imports = [ ./_hardware.nix ];
    };
  };
}
