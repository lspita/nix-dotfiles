{ den, ... }: {
  den.aspects.system.network.networkmanager = {
    includes = with den.aspects; [
      system.network
      system.network.networkmanager.wifiConnectivityFix
    ];

    nixos = { user, ... }: {
      networking.networkmanager.enable = true;
      users.users.${user.userName}.extraGroups = [ "networkmanager" ];
    };

    wifiConnectivityFix.nixos = {
      # fix wifi considered without internet access
      # https://discourse.nixos.org/t/is-gnome-supposed-to-detect-captive-portals/44417/4
      # converted to settings attribute because extraConfig is not supported anymore
      networking.networkmanager.settings.connectivity = {
        uri = "http://google.cn/generate_204";
        response = "";
      };
    };

    iwd.nixos = {
      networking = {
        wireless.iwd.enable = true;
        networkmanager.wifi.backend = "iwd";
      };
    };
  };
}
