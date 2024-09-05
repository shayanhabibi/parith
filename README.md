# Pointer Arithmetic in Nim


This module implements basic pointer arithmetic and other pointer
utilities for personal use.

## Credit

Original library by *Kaushal Modi* who credited most of the
code in the library to [this code snippet](https://forum.nim-lang.org/t/1188#7366) authored by
Nim Forum user *Jehan*.

## Usage

Ops are annotated with `!` to prevent unintentional use.

```nim
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
  echo &"after p +!= 1; p[] = 100   : a = {a}"

  p[0] = 200                                      # .. so does p[0]
  echo &"after p[0] = 200          : a = {a}"

  p[1] -= 2                                       # p[1] is accessing the contents of a[2]
  echo &"after p[1] -= 2           : a = {a}"

  p[2] += 50                                      # p[2] is accessing the contents of a[3]
  echo &"after p[2] += 50          : a = {a}"

  p +!= 2                                          # p is now pointing to a[3]
  p[-1] += 77                                     # p[-1] is accessing the contents of a[2]
  echo &"after p +!= 2; p[-1] += 77 : a = {a}"

  echo &"a[0] = p[-3] = {p[-3]}"
  echo &"a[1] = p[-2] = {p[-2]}"
  echo &"a[2] = p[-1] = {p[-1]}"
  echo &"a[3] = p[0] = {p[0]}"

  doAssert a == [0, 200, 77, 53]
```

Implements: `+!`, `-!`, `+!=`, `-!=`, `==!`, `!=!`

I chose `!` as the annotation arbitrarily to not interfere with `%` native annotation for unsigned arithmetic. In hindsight, it can visually be confusing as a `not` operation of sorts.

## Bitops

Bitwise op arithmetic is also available as a separate import to prevent misuse:

`import parith/bitops`

## Pointer String Formatting

String formatting for pointers is available to quickly convert
pointers to string in hex (`$!`) or bin (`$%`) format

`import parith/ptrformat`
