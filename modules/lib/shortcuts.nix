{ lib, ... }: {
  lib2.shortcuts = {
    type = with lib.types; listOf str;
  };
}
