defmodule ExampleTest do
  use ExUnit.Case
  doctest Example

  test "recursive get value by index" do
    assert Example.get_element_at([9, 8, 3, 5, 1], 4) == 1
  end
end
