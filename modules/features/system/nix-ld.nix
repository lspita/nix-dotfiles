{
  den.aspects.system.nix-ld.nixos = { pkgs, ... }: {
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
        stdenv.cc.cc.lib
      ];
    };
  };
}
