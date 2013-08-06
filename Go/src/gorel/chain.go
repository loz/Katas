package gorel

type Chain struct {
  table *Table
  wheres []string
}

func NewChainFromTable(table *Table) *Chain {
  c := Chain{table, []string{}}
  return &c
}

func (self *Chain) ToSql() string{
  return "SELECT * FROM " +
    self.table.QuotedName() +
    self.WhereString()
}

func (self *Chain) Where(w string) *Chain {
  self.wheres = append(self.wheres,w)
  return self
}

func (self *Chain) WhereString() string {
  str := " WHERE "
  wherecount := len(self.wheres) - 1
  if wherecount == 0 {
    str += self.wheres[wherecount]
  } else {
    for i := 0; i < wherecount; i++ {
      str += "(" + self.wheres[i] + ") AND "
    }
    str += "(" + self.wheres[wherecount] + ")"
  }
  return str
}
