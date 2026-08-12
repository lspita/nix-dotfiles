{ den, ... }: {
  den = {
    hosts.x86_64-linux.clank = {
      stateVersion = "26.11";
      graphics = "nvidia";
      users.lspita = { };
    };
    aspects.clank = with den.aspects; {
      includes = [
        kernel.latest
        boot.systemd-boot
        nix.settings
        home-manager
      ];

      os.imports = [ ./_hardware.nix ];
    };
  };
}
