#!/usr/bin/env elixir

list = [1,2,3,4]
IO.inspect Enum.map list, fn x -> x + 2 end
IO.inspect Enum.map list, &1 + 2

Enum.map list, fn x -> IO.puts x end
Enum.map list, IO.puts(&1)
