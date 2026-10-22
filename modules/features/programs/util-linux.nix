{
  den.aspects.programs.util-linux.nixos = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ util-linux ];
  };
}
