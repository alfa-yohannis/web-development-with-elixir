defmodule Lottery do
  def greet do
    "Good luck!"
  end

  def generate_pool do
    numbers = ["Number 1", "Number 2", "Number 3",
      "Number 4", "Number 5", "Number 6"]
    pots = ["Pot 1", "Pot 2", "Pot 3", "Pot 4"]

    for pot <- pots, number <- numbers do
      "#{number} in #{pot}"
    end
  end

  def randomize(pool) do
    Enum.shuffle(pool)
  end

  @spec contains?(any(), any()) :: boolean()
  def contains?(pool, number) do
    Enum.member?(pool, number)
  end

  def distribute(pool, draw_size) do
    Enum.split(pool, draw_size)
  end
end
