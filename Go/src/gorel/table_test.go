package gorel

import "testing"

type ExampleAdapter struct {
}

func NewExampleAdapter() *ExampleAdapter {
  a := ExampleAdapter{}
  return &a
}

func (self *ExampleAdapter) QuotedTableName(s string) string {
  return "§" + s + "§"
}

func assertEqual(t *testing.T, expected string, actual string) {
  if expected != actual {
    t.Error("Expected", expected, "Got", actual)
  }
}

var exampleAdapter ExampleAdapter = *NewExampleAdapter()

var exampleTable Table = *NewTable("example", &exampleAdapter)
var otherTable Table = *NewTable("other", &exampleAdapter)

func TestSelectAllSQL(t *testing.T) {
  sql := exampleTable.Where("1").ToSql()
  assertEqual(t, "SELECT * FROM §example§ WHERE 1", sql)
  sql = otherTable.Where("foo=bar").ToSql()
  assertEqual(t, "SELECT * FROM §other§ WHERE foo=bar", sql)
}

func TestChainWhere(t *testing.T) {
  sql := exampleTable.Where("foo").Where("bar").ToSql()
  assertEqual(t, "SELECT * FROM §example§ WHERE (foo) AND (bar)", sql)
}
