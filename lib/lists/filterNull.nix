_:
# list: list without null values
list: # list: original
builtins.filter (x: x != null) list
