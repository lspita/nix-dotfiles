{ config, lib, ... }:
with lib.custom;
modules.mkDefaultsModule config ./. {
  config =
    { setDefaultModules, ... }:
    setDefaultModules {
      nh.enable = true;
      direnv.enable = true;
      gh.enable = true;
      fastfetch.enable = true;
      lazycli.enable = true;
      lazygit.enable = true;
      lazydocker.enable = true;
      jq.enable = true;
      bat.enable = true;
      delta.enable = true;
      fzf.enable = true;
    };
}
