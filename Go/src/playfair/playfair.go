package playfair

import "fmt"

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
    parts[x][y] = charcode
    x += 1
    if x == 5 {
      x = 0
      y += 1
    }
  }
  self.key = parts
}

func (self *Playfair) encode(message string) string {
  fmt.Println("Key", self.key)
  return self.downshift(message)
}

func (self *Playfair) coords(code rune) []int {
  xy := make([]int, 2)
  return xy
}


func (self *Playfair) downshift(digraph string) string {
  for _, charcode := range digraph {
    fmt.Println(charcode)
  }
  return "HS"
}
