package gorel

type Table struct {
  name string
  adapter Adapter
}

func NewTable(name string, adapter Adapter) *Table {
  t := Table{name, adapter}
  t.Init()
  return &t
}

func (self *Table) Init() {
}

func (self *Table) Where(clause string) *Chain {
  c := NewChainFromTable(self)
  c.AddWhere(clause)
  return c
}

func (self *Table) QuotedName() string {
  return self.adapter.QuotedTableName(self.name)
}
