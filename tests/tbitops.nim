import std/[unittest]
import parith/bitops

suite "bitops":
  setup:
    type
      MyObject = object
        i: int
        f: float
        b: bool

    var
      a = [MyObject(i: 100, f: 2.3, b: true),
           MyObject(i: 300, f: 4.5, b: false),
           MyObject(i: 500, f: 6.7, b: true)]
      p = addr(a[0])

  test "bitwise and":
    check (p &! high(uint))[] == a[0]
