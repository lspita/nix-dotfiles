{ den, ... }: {
  den = {
    hosts.x86_64-linux.clank = {
      stateVersion = "26.11";
      graphics = "intel";
      users.lspita = { };
    };
    aspects.clank.includes = with den.aspects; [
      clank.hardware
      kernel.latest
      boot.systemd-boot
      nix
      home-manager
    ];
  };
}
