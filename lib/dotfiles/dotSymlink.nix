{ super }:
# string: path to out of store symlink
{ config, ... }@inputs: # set: config inputs
filePath: # string: relative path to file in repo
config.lib.file.mkOutOfStoreSymlink (super.dotPath inputs filePath)
