#!/usr/bin/env elixir

fizzbuzz = fn
  (0,0,_) -> "FizzBuzz"
  (0,_,_) -> "Fizz"
  (_,0,_) -> "Buzz"
  (_,_,x) -> x
end

buzzer = fn(n) ->
  fizzbuzz.(rem(n,3),rem(n,5), n)
end

IO.puts buzzer.(10)
IO.puts buzzer.(11)
IO.puts buzzer.(12)
IO.puts buzzer.(13)
IO.puts buzzer.(14)
IO.puts buzzer.(15)
IO.puts buzzer.(16)
