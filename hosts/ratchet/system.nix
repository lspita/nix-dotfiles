{ ... }:
{
  custom = {
    core.enableDefaults = true;
    services.enableDefaults = true;
    nixos = {
      core = {
        enableDefaults = true;
        boot.dualBoot = {
          enable = true;
          windows.entries = {
            "windows11" = {
              title = "Windows 11";
              efiDeviceHandle = "FS0";
              sortKey = "_windows11";
            };
          };
        };
      };
      services = {
        enableDefaults = true;
        openrgb.enable = true;
      };
      login.sddm.enable = true;
      desktop.plasma.enable = true;
      virtualisation.enableDefaults = true;
    };
  };
}
