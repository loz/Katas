package gorel

import "testing"

type ExampleAdapter struct {
}

func NewExampleAdapter() *ExampleAdapter {
  a := ExampleAdapter{}
  return &a
}

func assertEqual(t *testing.T, expected string, actual string) {
  if expected != actual {
    t.Error("Expected", expected, "Got", actual)
  }
}

var exampleAdapter ExampleAdapter = *NewExampleAdapter()

var subject Table = *NewTable("example", exampleAdapter)

func TestSelectAllSQL(t *testing.T) {
  sql := subject.Where("1").ToSql()
  assertEqual(t, "SELECT * FROM §example§ WHERE 1", sql)
}
