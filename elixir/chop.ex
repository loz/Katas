defmodule Chop do
  def mid(a..z), do: div(z-a, 2) + a

  def guess(actual, range), do: guesser(actual, range, mid(range))

  def guesser(actual, _, actual) do
    IO.puts actual
  end

  def guesser(actual, l.._, mid) when mid > actual do
    IO.puts "Is it #{mid}"
    guess(actual, l..(mid-1))
  end

  def guesser(actual, _..u, mid) do
    IO.puts "Is it #{mid}"
    guess(actual, (mid+1)..u)
  end

end
