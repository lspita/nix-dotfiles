{ lib, ... }: {
  den.aspects.system.audio.pipewire.nixos = {
    security.rtkit.enable = true;
    services = {
      pulseaudio.enable = lib.mkForce false;
      pipewire = {
        enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        pulse.enable = true;
        jack.enable = true;
      };
    };
  };
}
