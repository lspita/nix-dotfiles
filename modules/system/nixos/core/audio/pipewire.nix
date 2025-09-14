{
  config,
  lib,
  ...
}:
lib.custom.mkModule {
  inherit config;
  path = [
    "nixos"
    "core"
    "audio"
    "pipewire"
  ];
  mkConfig =
    { ... }:
    {
      assertions = [
        {
          assertion = config.services.pulseaudio.enable == false;
          message = "Cannot enable both pulseaudio and pipewire at the same time.";
        }
      ];
      security.rtkit.enable = true;
      services = {
        pulseaudio.enable = false;
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
