defmodule MathTest do
  use ExUnit.Case
   doctest Math

  test "greets the world" do
    assert Math.hello() == "Hello World!"
  end

  test "test Math.add(a, b)" do
    assert Math.add(10,1) == 11
  end

  test "multiplies two numbers" do
    assert Math.multiply(4, 5) == 20
  end

  test "divides two numbers" do
  assert Math.divide(10, 2) == 5
  end

  test "divides by zero raises an error" do
  assert_raise ArithmeticError , fn -> Math.divide(10, 0) end
  end

end
