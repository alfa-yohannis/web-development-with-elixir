defmodule AvatarGenerator do
  use Application

  def generate(input) do
    input
    |> compute_hash
    |> select_color
    |> create_grid
    |> remove_odd_cells
    |> generate_pixel_map
    |> render_image
    |> store_image(input)
  end

  def store_image(image, input) do
    File.write("#{input}_avatar.png", image)
  end

  def render_image(%Avatar.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each pixel_map, fn({start, stop}) ->
      :egd.filledRectangle(image, start, stop, fill)
    end

    :egd.render(image)
  end


  def generate_pixel_map(%Avatar.Image{grid: grid} = image) do
    pixel_map = Enum.map grid, fn({_value, index}) ->
      x = rem(index, 5) * 50
      y = div(index, 5) * 50

      top_left = {x, y}
      bottom_right = {x + 50, y + 50}

      {top_left, bottom_right}
    end

    %Avatar.Image{image | pixel_map: pixel_map}
  end

  def remove_odd_cells(%Avatar.Image{grid: grid} = image) do
    grid = Enum.filter grid, fn({value, _index}) ->
      rem(value, 2) == 0
    end

    %Avatar.Image{image | grid: grid}
  end

  def create_grid(%Avatar.Image{hash: hash} = image) do
    grid = hash
    |> Enum.chunk_every(3)
    |> Enum.map(&reflect_row/1)
    |> List.flatten
    |> Enum.with_index

    %Avatar.Image{image | grid: grid}
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

      # IO.inspect(hash)
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
    result = AvatarGenerator.generate("batman")
    IO.inspect(result)
    IO.puts("Finished!")
    {:ok, self()}
  end
end
