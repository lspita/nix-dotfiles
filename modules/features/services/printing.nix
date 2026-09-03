{ den, ... }: {
  den.aspects.services.printing = {
    includes = with den.aspects; [ services.printing.avahi ];

    nixos = { pkgs, ... }: {
      services.printing = {
        drivers = with pkgs; [
          cups-filters
          cups-browsed
        ];
        enable = true;
      };
    };

    avahi.nixos.services.avahi = {
      enable = true;
      # https://wiki.nixos.org/wiki/Printing
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
