{ super }:
{ config, ... }@inputs:
path: config.lib.file.mkOutOfStoreSymlink (super.dotPath inputs path)
