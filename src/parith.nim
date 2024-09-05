## :Author: Kaushal Modi
## Edits: Shayan Habibi
## :License: MIT
##
## Introduction
## ============
## This module implements basic Pointer Arithmetic functions.
##
## Source
## ======
## `Repo link <https://github.com/kaushalmodi/ptr_math>`_
##
## The code in this module is mostly from `this code snippet <https://forum.nim-lang.org/t/1188#7366>`_ on Nim Forum.

import parith/math
export math

proc `[]=`*[T; S: SomeInteger](p: ptr T, offset: S, val: T) {.deprecated: "Unsafe usage, likely to be removed from API".} =
  ## Assigns the value at memory location pointed by `p[offset]`.
  (p +! offset)[] = val

proc `[]`*[T; S: SomeInteger](p: ptr T, offset: S): var T {.deprecated: "Unsafe usage, likely to be removed from API".} =
  ## Retrieves the value from `p[offset]`.
  return (p +! offset)[]


iterator items*[T](start: ptr T, stopBefore: ptr T): lent T =
  ## Iterates over contiguous `ptr T`s, from `start` excluding `stopBefore`. Yields immutable `T`.
  var p = start
  while p != stopBefore:
    yield p[]
    p +!= 1

iterator mitems*[T](start: ptr T, stopBefore: ptr T): var T =
  ## Iterates over contiguous `ptr T`s, from `start` excluding `stopBefore`. Yields mutable `T`.
  var p = start
  while p != stopBefore:
    yield p[]
    p +!= 1

iterator items*[T](uarray: UncheckedArray[T] | ptr T, len: SomeInteger): lent T =
  ## Iterates over `UncheckedArray[T]` or `ptr T` array with length. Yields immutable `T`.
  for i in 0..<len:
    yield uarray[i]

# As of 1.6.0 mitems and mpairs for var UncheckedArray[t] and ptr T cannot be combined
# like their immutable versions. https://forum.nim-lang.org/t/8557#55560

iterator mitems*[T](uarray: var UncheckedArray[T], len: SomeInteger): var T =
  ## Iterates over `var UncheckedArray[T]` with length. Yields mutable `T`.
  for i in 0..<len:
    yield uarray[i]

iterator mitems*[T](p: ptr T, len: SomeInteger): var T =
  ## Iterates over `ptr T` with length. Yields mutable `T`.
  for i in 0..<len:
    yield p[i]

iterator pairs*[T; S:SomeInteger](uarray: UncheckedArray[T] | ptr T, len: S): (S, lent T) =
  ## Iterates over `UncheckedArray[T]` or `ptr T` array with length. Yields immutable `(index, uarray[index])`.
  for i in S(0)..<len:
    yield (i, uarray[i])


iterator mpairs*[T; S: SomeInteger](uarray: var UncheckedArray[T], len: S): (S, var T) =
  ## Iterates over `var UncheckedArray[T]` with length. Yields `(index, uarray[index])` with mutable `T`.
  for i in S(0)..<len:
    yield (i, uarray[i])

iterator mpairs*[T; S: SomeInteger](p: ptr T, len: S): (S, var T) =
  ## Iterates over `ptr T` array with length. Yields `(index, p[index])` with mutable `T`.
  for i in S(0)..<len:
    yield (i, p[i])

when isMainModule:
  import std/[strformat]

  var
    a: array[0 .. 3, int]
    p = addr(a[0])                                # p is pointing to a[0]

  for i, _ in a:
    a[i] += i
  echo &"before                    : a = {a}"

  p +!= 1                                          # p is now pointing to a[1]
  p[] = 100                                       # p[] is accessing the contents of a[1]
  echo &"after p += 1; p[] = 100   : a = {a}"

  p[0] = 200                                      # .. so does p[0]
  echo &"after p[0] = 200          : a = {a}"

  p[1] -= 2                                       # p[1] is accessing the contents of a[2]
  echo &"after p[1] -= 2           : a = {a}"

  p[2] += 50                                      # p[2] is accessing the contents of a[3]
  echo &"after p[2] += 50          : a = {a}"

  p +!= 2                                          # p is now pointing to a[3]
  p[-1] += 77                                     # p[-1] is accessing the contents of a[2]
  echo &"after p += 2; p[-1] += 77 : a = {a}"

  echo &"a[0] = p[-3] = {p[-3]}"
  echo &"a[1] = p[-2] = {p[-2]}"
  echo &"a[2] = p[-1] = {p[-1]}"
  echo &"a[3] = p[0] = {p[0]}"

  doAssert a == [0, 200, 77, 53]
