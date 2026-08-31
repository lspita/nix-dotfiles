{ den, ... }: {
  den = {
    hosts.x86_64-linux.clank = {
      stateVersion = "26.11";
      graphics = "intel";
      users.lspita = {
        shell = "zsh";
        profile.image = "clank";
      };
    };
    aspects.clank.includes = with den.aspects; [
      clank.hardware
      kernel.latest
      system.boot.systemd-boot
      system.boot.plymouth
      system.audio.pipewire
      system.fs.exfat
      nix
      home-manager
      shell.prompt.starship
      dev.probe-rs
      dev.android
      dev.platformio
      services.openssh
    ];
  };
}
