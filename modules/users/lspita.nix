{ den, ... }:
{
  den.aspects.lspita.includes = with den.batteries; [
    primary-user
    (user-shell "zsh")
  ];
}
