package gorel

type Chain struct {
  table *Table
  wheres string
}

func NewChainFromTable(table *Table) *Chain {
  c := Chain{table, ""}
  return &c
}

func (self *Chain) ToSql() string{
  return "SELECT * FROM " +
    self.table.QuotedName() +
    " WHERE " +
    self.wheres
}

func (self *Chain) AddWhere(w string) {
  self.wheres = w
}
