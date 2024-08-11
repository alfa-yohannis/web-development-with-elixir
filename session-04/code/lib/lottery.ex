defmodule Lottery do
  @moduledoc """
  This module provides functionalities for managing a lottery system.
  It includes functions for creating, shuffling, checking for numbers, saving, loading, and distributing numbers within the lottery pool.
  """

  @doc """
  Generates a pool of lottery numbers with different pots.

  ## Returns

    - A list of lottery numbers with their respective pot numbers.

   ## Examples

      iex> Lottery.generate_pool()
      [
        "Number 1 in Pot 1", "Number 2 in Pot 1", "Number 3 in Pot 1", "Number 4 in Pot 1", "Number 5 in Pot 1",
        "Number 1 in Pot 2", "Number 2 in Pot 2", "Number 3 in Pot 2", "Number 4 in Pot 2", "Number 5 in Pot 2",
        "Number 1 in Pot 3", "Number 2 in Pot 3", "Number 3 in Pot 3", "Number 4 in Pot 3", "Number 5 in Pot 3",
        "Number 1 in Pot 4", "Number 2 in Pot 4", "Number 3 in Pot 4", "Number 4 in Pot 4", "Number 5 in Pot 4"
      ]
  """
  def generate_pool do
    numbers = ["Number 1", "Number 2", "Number 3", "Number 4", "Number 5"]
    pots = ["Pot 1", "Pot 2", "Pot 3", "Pot 4"]

    # Creates a pool by combining numbers and pots.
    for pot <- pots, number <- numbers do
      "#{number} in #{pot}"
    end
  end

  @doc """
  Randomizes the order of numbers in the pool.

  ## Parameters

    - pool: The list of lottery numbers to be shuffled.

  ## Returns

    - A new list with the numbers shuffled.

  ## Examples

      iex> pool = ["Number 1 in Pot 1", "Number 2 in Pot 2"]
      iex> randomized_pool = Lottery.randomize(pool)
      iex> Enum.sort(randomized_pool) == Enum.sort(pool)
      true
  """
  def randomize(pool) do
    Enum.shuffle(pool)
  end

  @doc """
  Checks if a specific number is included in the pool.

  ## Parameters

    - pool: The list of lottery numbers.
    - number: The number to check for.

  ## Returns

    - `true` if the number is in the pool, otherwise `false`.

  ## Examples

      iex> Lottery.contains?(["Number 1 in Pot 1"], "Number 1 in Pot 1")
      true
  """
  def contains?(pool, number) do
    Enum.member?(pool, number)
  end

  @doc """
  Distributes the pool into two parts based on the specified draw size.

  ## Parameters

    - pool: The list of lottery numbers to be split.
    - draw_size: The number of numbers to include in the first part.

  ## Returns

    - A tuple with two lists: the first list containing `draw_size` numbers, and the second list containing the remaining numbers.

  ## Examples

      iex> Lottery.distribute(["Number 1 in Pot 1", "Number 2 in Pot 2"], 1)
      {["Number 1 in Pot 1"], ["Number 2 in Pot 2"]}
  """
  def distribute(pool, draw_size) do
    Enum.split(pool, draw_size)
  end

  @doc """
  Saves the lottery pool to a file.

  ## Parameters

    - pool: The list of lottery numbers to be saved.
    - filename: The name of the file to save the pool in.

  ## Examples

      iex> Lottery.save_pool(["Number 1 in Pot 1"], "lottery_pool.dat")
      :ok
  """
  def save_pool(pool, filename) do
    binary = :erlang.term_to_binary(pool)
    File.write(filename, binary)
  end

  @doc """
  Loads a lottery pool from a file.

  ## Parameters

    - filename: The name of the file to load the pool from.

  ## Returns

    - The loaded lottery pool, or an error message if the file doesn't exist.

  ## Examples

      iex> Lottery.load_pool("lottery_pool.dat")
      ["Number 1 in Pot 1"]
  """
  def load_pool(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end
  end

  @doc """
  Creates a randomized hand from the lottery pool.

  ## Parameters

    - draw_size: The number of numbers to include in the hand.

  ## Returns

    - A tuple with the hand and the remaining pool.

  ## Examples

      iex> {hand, _remaining_pool} = Lottery.create_hand(1)
      iex> length(hand) == 1
      true
  """
  def create_hand(draw_size) do
    Lottery.generate_pool()
    |> Lottery.randomize()
    |> Lottery.distribute(draw_size)
  end
end
