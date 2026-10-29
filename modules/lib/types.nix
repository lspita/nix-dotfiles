{ lib, ... }: {
  lib2.types = rec {
    deepAttrsOf = leafType: with lib.types; lazyAttrsOf (either leafType (deepAttrsOf leafType));
  };
}
