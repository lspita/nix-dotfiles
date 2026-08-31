{
  den.aspects.system.fs.exfat.nixos = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # exfat support
      exfat
      exfatprogs
    ];
  };
}
