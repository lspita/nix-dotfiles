_:
{ options, ... }: # set: config inputs
program: # string: program name
options.programs.${program}.package.default
