{ den, ... }: {
  den = {
    hosts.x86_64-linux.clank = {
      stateVersion = "26.11";
      graphics = "intel";
      users.lspita = {
        fullName = "Ludovico Spitaleri";
        email = "ludovico.spitaleri@gmail.com";
        shell = "zsh";
        profile.image = "clank";
      };
      locale = {
        default = "en_DK.UTF-8";
        keyboard = "it";
      };
    };
    aspects.clank.includes = with den.aspects; [
      clank.hardware
      system.kernel.latest
      system.boot.systemd-boot
      system.boot.plymouth
      system.audio.pipewire
      system.fs.exfat
      system.locale
      system.locale.hunspell
      system.network
      system.network.networkmanager
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
