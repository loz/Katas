defmodule MyEnum do
  def sum(x), do: _sum(x, 0)

  def _sum([], total), do: total
  def _sum([ head | tail ], total), do: _sum(tail, head+total)


  def all?([], _func), do: true
  def all?([head | tail], func), do: func.(head) && all?(tail, func)

  def each([], _func), do: :ok
  def each([head | tail], func) do
    func.(head)
    each(tail, func)
  end

  def filter([], _func), do: []
  def filter([head | tail], func), do: _filter([head | tail], func, func.(head))
  def _filter([head | tail], func, true), do: [head | filter(tail, func)]
  def _filter([_head | tail], func, false), do: filter(tail, func)

  def split(collection, n), do: _split(collection, n, {[], []})
  def _split([], _, result), do: result
  def _split([head | tail], 0, {l,r}), do: _split(tail, 0, {l, r ++ [head]})
  def _split([head | tail], n, {l,r}), do: _split(tail, n-1, {l ++ [head], r})

  def take(_, 0), do: []
  def take([head | tail], n), do: [head | take(tail, n-1)]


  def span(x,x), do: [x]
  def span(x,y), do: [x | span(x+1, y)]
end


list = [1,2,3,4,5,6]

IO.puts MyEnum.all? list, &1 < 6
IO.puts MyEnum.all? list, &1 < 4

IO.puts MyEnum.each list, IO.puts(&1)
IO.inspect MyEnum.filter list, fn x -> rem(x,2) == 0 end
IO.inspect MyEnum.filter list, fn x -> rem(x,2) == 1 end

IO.inspect MyEnum.split list, 4
IO.inspect MyEnum.split list, 3
IO.inspect MyEnum.split list, 2

IO.inspect MyEnum.take list, 4
IO.inspect MyEnum.take list, 3
IO.inspect MyEnum.take list, 2

IO.inspect MyEnum.span(5,24)
