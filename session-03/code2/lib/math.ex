defmodule Math do
  @moduledoc """
  Module untuk melakukan perhitungan matematis.
  """

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
