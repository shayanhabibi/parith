import std/strformat

proc `$!`*[T: ptr | pointer](p: T): string =
  ## Returns the pointer as a hexadecimal string.
  return fmt"{cast[uint](p):#X}"

proc `$%`*[T: ptr | pointer](p: T): string =
  ## Returns the pointer as a binary string.
  return fmt"{cast[uint](p):#b}"


when isMainModule:
  var p: pointer
  echo $!addr(p)
  echo $%addr(p)
