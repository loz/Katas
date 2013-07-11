Code.require_file "../test_helper.exs", __FILE__

defmodule DocTest do
  use ExUnit.Case

  doctest Issues.TableFormatter
end
