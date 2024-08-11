defmodule LotteryTest do
  use ExUnit.Case
  doctest Lottery

  test "generate_pool creates 20 lottery numbers" do
    pool_length = length(Lottery.generate_pool())
    assert pool_length == 20
  end

  test "randomizing a pool shuffles it" do
    pool = Lottery.generate_pool()
    refute pool == Lottery.randomize(pool)
  end
end
