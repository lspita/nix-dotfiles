{ ... }: filename: builtins.head (builtins.match "(.*)\\..*" filename)
