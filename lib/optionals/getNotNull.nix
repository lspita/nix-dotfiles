{ super }:
# any: `default` if `value` is null, else `value`
default: # any: default value
value: # any: original value
super.ifNotNull default value value
