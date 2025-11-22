_:
# string: file name without last extension
filename: # string: file name
builtins.head (builtins.match "(.*)\\..*" filename)
