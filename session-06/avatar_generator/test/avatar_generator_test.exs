defmodule AvatarGeneratorTest do
  use ExUnit.Case
  doctest AvatarGenerator

  test "greets the world" do
    assert AvatarGenerator.hello() == :world
  end
end
