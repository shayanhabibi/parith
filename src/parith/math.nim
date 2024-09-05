proc `+!`*[T; S: SomeInteger](p: ptr T, offset: S): ptr T =
  ## Increments pointer `p` by `offset` that jumps memory in increments of
  ## the size of `T`.
  return cast[ptr T](cast[ByteAddress](p) +% (int(offset) * sizeof(T)))
  #                                      `+%` treats x and y inputs as unsigned
  # and adds them: https://nim-lang.github.io/Nim/system.html#%2B%25%2Cint%2Cint

proc `+!`*[S: SomeInteger](p: pointer, offset: S): pointer =
  ## Increments pointer `p` by `offset` that jumps memory in increments of
  ## single bytes.
  return cast[pointer](cast[ByteAddress](p) +% int(offset))

proc `-!`*[T; S: SomeInteger](p: ptr T, offset: S): ptr T =
  ## Decrements pointer `p` by `offset` that jumps memory in increments of
  ## the size of `T`.
  return cast[ptr T](cast[ByteAddress](p) -% (int(offset) * sizeof(T)))

proc `-!`*[S: SomeInteger](p: pointer, offset: S): pointer =
  ## Decrements pointer `p` by `offset` that jumps memory in increments of
  ## single bytes.
  return cast[pointer](cast[ByteAddress](p) -% int(offset))

proc `+!=`*[T; S: SomeInteger](p: var ptr T, offset: S) =
  ## Increments pointer `p` *in place* by `offset` that jumps memory
  ## in increments of the size of `T`.
  p = p +! offset

proc `+!=`*[S: SomeInteger](p: var pointer, offset: S) =
  ## Increments pointer `p` *in place* by `offset` that jumps memory
  ## in increments of single bytes.
  p = p +! offset

proc `-!=`*[T; S: SomeInteger](p: var ptr T, offset: S) =
  ## Decrements pointer `p` *in place* by `offset` that jumps memory
  ## in increments of the size of `T`.
  p = p -! offset

proc `-!=`*[S: SomeInteger](p: var pointer, offset: S) =
  ## Decrements pointer `p` *in place* by `offset` that jumps memory
  ## in increments of single bytes.
  p = p -! offset
