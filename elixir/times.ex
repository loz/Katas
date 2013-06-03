defmodule Times do
  def double(n) do
    n * 2
  end

  def tripple(n) do
    n * 3
  end

  def quadruple(n) do
    double(double(n))
  end
end
