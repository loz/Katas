#!/usr/bin/env elixir

prefix = fn(pref) -> (fn(name) -> "#{pref} #{name}" end) end

mrs = prefix.("Mrs")
IO.puts mrs.("Smith")

IO.puts prefix.("Elixir").("Rocks")
