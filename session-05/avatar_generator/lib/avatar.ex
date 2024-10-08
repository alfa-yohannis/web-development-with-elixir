defmodule AvatarGenerator do
  use Application

  def generate(input) do
    input
    |> compute_hash
    |> select_color
    |> create_grid
  end

  def create_grid(%Avatar.Image{hash: hash} = image) do
    hash
    |> Enum.chunk_every(3)
    |> Enum.map(&reflect_row/1)
    |> List.flatten
    |> Enum.with_index
  end

  def reflect_row(row) do
    [ first, second | _tail] = row
    row ++ [second, first]
  end

  def compute_hash(input) do
    hash =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()
      |> resize_list

      IO.inspect(hash)
    %Avatar.Image{hash: hash}
  end

  def resize_list(list) do
    full_chunks_count = div(length(list), 3) * 3
    Enum.take(list, full_chunks_count)
  end

  def select_color(%Avatar.Image{hash: [r, g, b | _tail]} = image) do
    %Avatar.Image{image | color: {r, g, b}}
  end

  def start(_type, _args) do
    result = AvatarGenerator.generate("wolverine")
    IO.inspect(result)
    {:ok, self()}
  end
end
