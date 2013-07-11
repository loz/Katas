defmodule Issues.TableFormatter do

  def print_table_for_columns(rows, headers) do
    data_by_columns = split_into_columns(rows, headers)
    column_widths   = widths_of(data_by_columns)
    format          = format_for(column_widths)

    puts_one_line_in_columns headers, format
    IO.puts                  separator(column_widths)
    puts_in_columns          rows, headers, format
  end

  @doc """
  Given a list or rows, where each row contains a keyed list of columns,
  return a list containing lists of the data in each column. The `headers`
  parameter contains the list of columns to extract

  ## Example

      iex> list = [ [ {"a", "1"}, {"b", "2"}, {"c", "3"}],
      ...>          [ {"a", "4"}, {"b", "5"}, {"c", "6"}] ]
      iex> Issues.TableFormatter.split_into_columns(list, [ "a", "b", "c" ])
      [ ["1", "4"], ["2", "5"], ["3", "6"] ]
  """
  def split_into_columns(rows, headers) do
    lc header inlist headers do
      lc row inlist rows, do: printable(row[header])
    end
  end

  @doc """
  Return a binary (string) version of our parameter.

  ## Examples

      iex> Issues.TableFormatter.printable("a")
      "a"
      iex> Issues.TableFormatter.printable(99)
      "99.0"
  """
  def printable(str) when is_binary(str), do: str
  def printable(str), do: to_binary(str)

  def widths_of(columns) do
    max_width = fn field, max_length -> max(String.length(field), max_length) end
    lc column inlist columns do
      Enum.reduce column, 0, max_width
    end
  end

  def format_for(column_widths) do
    Enum.map_join(column_widths, " | ", fn width -> "~-#{width}s" end) <> "~n"
  end

  def separator(column_widths) do
    Enum.map_join(column_widths, "-+-", fn width -> List.duplicate("-", width) end)
  end

  def puts_in_columns([], _headers, _format), do: []
  def puts_in_columns([row|tail], headers, format) do
    extract = lc header inlist headers, do: printable(row[header])
    puts_one_line_in_columns extract, format
    puts_in_columns tail, headers, format
  end

  def puts_one_line_in_columns(fields, format) do
    :io.format(format, fields)
  end
end
