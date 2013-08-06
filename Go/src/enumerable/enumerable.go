package enumerable

type EnumerableArray struct {
  original [4]int
}

func _EnumerableArray(a [4]int) *EnumerableArray {
  e := EnumerableArray{a}
  return &e
}

func (self *EnumerableArray) each(fn func(int)) {
  for _, v := range self.original {
    fn(v)
  }
}
