defmodule MathTest do
  use ExUnit.Case
  doctest Math

  test "greets the world" do
    assert Math.hello() == "Hello World!"
  end

  test "test Math.add(a, b)" do
    assert Math.add(10,1) == 11
  end

end
