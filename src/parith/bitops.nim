type
  SomePointer = ptr | pointer

proc `&!`*[A: SomePointer; B: Natural](a: A, b: B): A =
  ## Bitwise ANDs the pointer `a` with the integer `b`.
  return cast[A](cast[uint](a) and uint(b))

proc `|!`*[A: SomePointer; B: Natural](a: A, b: B): A =
  ## Bitwise ORs the pointer `a` with the integer `b`.
  return cast[A](cast[uint](a) or uint(b))

proc `^!`*[A: SomePointer; B: Natural](a: A, b: B): A =
  ## Bitwise XORs the pointer `a` with the integer `b`.
  return cast[A](cast[uint](a) xor uint(b))

proc `<<!`*[A: SomePointer; B: Positive](a: A, b: B): A =
  ## Shifts the pointer `a` to the left by the integer `b`.
  return cast[A](cast[uint](a) shl uint(b))

proc `>>!`*[A: SomePointer; B: Positive](a: A, b: B): A =
  ## Shifts the pointer `a` to the right by the integer `b`.
  return cast[A](cast[uint](a) shr uint(b))

proc `~!`*[A: SomePointer](a: A): A =
  ## Bitwise NOTs the pointer `a`.
  return cast[A](not cast[uint](a))
