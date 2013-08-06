package gorel

type Chain struct {
}

func NewChainFromTable(table *Table) *Chain {
  c := Chain{}
  return &c
}

func (self *Chain) ToSql() string{
  return "SELECT * FROM §example§ WHERE 1"
}
