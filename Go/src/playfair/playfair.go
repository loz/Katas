package playfair

//import "fmt"

type Playfair struct {
  keytext string
  key [][5]rune
}

func NewPlayfair(keytext string) *Playfair {
  p := Playfair{keytext, nil}
  p.Init()
  return &p
}

func (self *Playfair) Init() {
  parts := make([][5]rune, 5)
  x := 0
  y := 0
  for _, charcode := range self.keytext {
    parts[y][x] = charcode
    x += 1
    if x == 5 {
      x = 0
      y += 1
    }
  }
  self.key = parts
}

func (self *Playfair) encode(message string) string {
  digraph := self.make_digraph(message)
  if self.in_column(digraph) {
    return self.downshift(digraph)
  }
  return self.rightshift(digraph)
}

func (self *Playfair) in_column(pair [][]int) bool {
  return pair[0][0] == pair [1][0]
}

func (self *Playfair) coords(code rune) []int {
  xy := make([]int, 2)
  for y, row := range self.key {
    for x, char := range row {
      if code == char {
        xy[0] = x
        xy[1] = y
      }
    }
  }
  return xy
}

func (self *Playfair) charat(x int, y int) string {
  return string(self.key[y][x])
}

func (self *Playfair) make_digraph(chars string) [][]int {
  digraph := make([][]int, 2)
  for i, code := range chars {
    digraph[i] = self.coords(code)
  }
  return digraph
}


func (self *Playfair) downshift(digraph [][]int) string {
  shifted := ""
  for _, xy := range digraph {
    if xy[1] == 4 {
      shifted += self.charat(xy[0], 0)
    } else {
      shifted += self.charat(xy[0], xy[1]+1)
    }
  }
  return shifted
}

func (self *Playfair) rightshift(digraph [][]int) string {
  shifted := ""
  for _, xy := range digraph {
    if xy[0] == 4 {
      shifted += self.charat(0, xy[1])
    } else {
      shifted += self.charat(xy[0]+1, xy[1])
    }
  }
  return shifted
}

