defmodule Lottery do
  @moduledoc """
  This module provides functionalities for managing a lottery system.
  It includes functions for creating, shuffling, checking for numbers, and distributing numbers within the lottery pool.
  """

  @spec greet() :: <<_::80>>
  @doc """
  Returns a greeting message.

  ## Examples

      iex> Lottery.greet()
      "Good luck!"
  """
  def greet do
    "Good luck!"
  end

  @spec generate_pool() :: [<<_::24, _::_*16>>, ...]
  @doc """
  Generates a pool of lottery numbers with different pots.

  ## Returns

    - A list of lottery numbers with their respective pot numbers.

  ## Examples

      iex> Lottery.generate_pool()
      ["Number 1 in Pot 1", "Number 2 in Pot 1", ...]
  """
  def generate_pool do
    numbers = ["Number 1", "Number 2", "Number 3", "Number 4", "Number 5", "Number 6"]
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

      iex> Lottery.randomize(["Number 1 in Pot 1", "Number 2 in Pot 2"])
      ["Number 2 in Pot 2", "Number 1 in Pot 1"]
  """
  def randomize(pool) do
    Enum.shuffle(pool)
  end

  @spec contains?(any(), any()) :: boolean()
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
end
