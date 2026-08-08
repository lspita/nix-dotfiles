{ den, ... }: {
  den = {
    hosts.x86_64-linux.clank = {
      stateVersion = "26.11";
      graphics = "intel";
      users.lspita = { };
    };
    aspects.clank = {
      includes = [
        den.aspects.systemd-boot
        den.aspects.nix
        den.aspects.nixpkgs
      ];

      os.imports = [ ./_hardware.nix ];
    };
  };
}
