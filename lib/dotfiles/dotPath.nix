{ super }:
# string: full path of file in this repo
inputs: # set: config inputs
filePath: # string: relative path to file
"${super.dotRoot inputs}/${filePath}"
