package gorel

type Adapter interface {
  QuotedTableName(s string) string
}
