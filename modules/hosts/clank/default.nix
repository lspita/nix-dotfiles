{
  den,
  lib,
  lib2,
  meta,
  ...
}:
{
  den = {
    hosts.x86_64-linux.clank = {
      stateVersion = "26.11";
      graphics = "intel";
      users = { inherit (meta.users) lspita; };
      locale = {
        default = "en_DK.UTF-8";
        keyboard = "it";
        languages = [
          "en_US"
          "en_GB"
          "it_IT"
        ];
      };
      theme = "catppuccin";
      themes.catppuccin = {
        flavor = "mocha";
        accent = "sapphire";
      };
      fonts =
        with meta.fonts;
        {
          normal = noto-sans-nf;
          monospace = jetbrains-mono-nf;
        }
        |> lib.mapAttrs (_: lib2.fonts.withSize 11);
      programs = rec {
        terminal = meta.programs.kitty;
        browser.exec = "firefox";
        editor = {
          desktop = "dev.zed.Zed.desktop";
          exec = "zeditor";
        };
        terminalEditor.exec = "nano";
        music.exec = "spotify";
        mail = browser;
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
      system.bluetooth
      system.documentation
      system.firmware.all
      system.nix-ld
      system.wayland
      system.xdg
      services.fingerprint
      services.location
      services.printing
      services.ssh
      services.udev
      (virtualisation.containers "podman")
      virtualisation.docker
      virtualisation.podman
      virtualisation.libvirtd
      login.sddm
      fonts.noto
      fonts.noto-nf
      fonts.jetbrains-mono-nf
      fonts.fira-code-nf
      fonts.fira-mono-nf
      nix
      home-manager
      shell.prompt.starship
      dev.probe-rs
      dev.android
      dev.platformio
      programs.kitty
    ];
  };
}
