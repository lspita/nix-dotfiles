_:
# string: font string representation
{
  name, # string: font name
  size, # int: font size
}:
"${name} ${toString size}"
