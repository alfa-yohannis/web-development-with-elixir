defmodule Lottery do
  def generate_pool do
    numbers = ["Number 1", "Number 2", "Number 3", "Number 4", "Number 5"]
    pots = ["Pot 1", "Pot 2", "Pot 3", "Pot 4"]

    # Creates a pool by combining numbers and pots.
    for pot <- pots, number <- numbers do
      "#{number} in #{pot}"
    end
  end

  def randomize(pool) do
    Enum.shuffle(pool)
  end

  def contains?(pool, number) do
    Enum.member?(pool, number)
  end

  def distribute(pool, draw_size) do
    Enum.split(pool, draw_size)
  end

  def save_pool(pool, filename) do
    binary = :erlang.term_to_binary(pool)
    File.write(filename, binary)
  end

  def load_pool(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end
  end

  def create_hand(draw_size) do
    Lottery.generate_pool()
    |> Lottery.randomize()
    |> Lottery.distribute(draw_size)
  end

  def create_hand(draw_size, pool) do
    pool
    |> Lottery.randomize()
    |> Lottery.distribute(draw_size)
  end
end
