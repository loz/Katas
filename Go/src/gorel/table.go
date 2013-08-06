package gorel

type Table struct {
  name string
  adapter Adapter
}

func NewTable(name string, adapter Adapter) *Table {
  t := Table{name,adapter}
  t.Init()
  return &t
}

func (self *Table) Init() {
}

func (self *Table) Where(clause string) *Chain {
  return NewChainFromTable(self)
}

