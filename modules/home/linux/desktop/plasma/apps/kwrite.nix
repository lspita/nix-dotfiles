{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./kwrite.nix {
  config = {
    programs.plasma.configFile.kwriterc."KTextEditor View"."Scroll Past End" = true;
  };
}
