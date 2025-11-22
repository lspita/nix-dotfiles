_:
# any: `default` if `value` is null, else `result`
default: # any: default value
result: # any: resulting value
value: # any: original value
if builtins.isNull value then default else result
