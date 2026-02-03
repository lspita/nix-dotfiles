{ lib, ... }@inputs:
with lib.custom;
modules.mkModule inputs ./discord.nix {
  config = {
    programs.discord = {
      enable = true;
      settings = {
        DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING = true; # what could go wrong :)
        SKIP_HOST_UPDATE = true;
      };
    };
  };
}
