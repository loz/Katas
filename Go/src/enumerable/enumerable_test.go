package enumerable

import "testing"

//Enumerable Array
var normalArray = [4]int{ 1, 2, 3, 4 }
var array *EnumerableArray = _EnumerableArray(normalArray)

func square(x int) int {
  return x * x
}

func TestEnumerableSupportsEach(t *testing.T) {
  squares := []int{}
  array.each(func (i int) {
    squares = append(squares, square(i))
  })

  for _, v := range normalArray {
    expected := square(v)
    actual := squares[v-1]
    if expected != actual {
      t.Error("Incorrect Square of",v, "expected",  expected, "Got", actual)
    }
  }
}
