defmodule Math do
  @moduledoc """
  Module untuk melakukan perhitungan matematis.
  """

  @doc """
  Multiplies two numbers.

    ## Parameters

      - x: the first number.
      - y: the second number.

    ## Example

      iex> Math.multiply(4, 5)
      20
  """
  def multiply(x, y) do
    x * y
  end

  @doc """
  Divides two numbers.

    ## Parameters

      - x: the numerator.
      - y: the denominator.

    ## Example

      iex> Math.divide(10, 2)
      5.0
"""
  def divide(x, y) do
    x / y
  end


  @doc """
  Fungsi ini menambahkan dua angka yang dimasukkan sebagai
  parameter.

  ## Parameters

      - a: angka parameter pertama
      - b: angka parameter kedua

  ## Example

      iex> Math.add(1, 2)
      3

  """
  def add(a, b) do
    a + b
  end

  @doc """
  Hello world.

  ## Examples

      iex> Math.hello()
      "Hello World!"

  """
  def hello do
    "Hello World!"
  end
end
