defmodule Example do
  def get_element_at([head | _tail], 0) do
    str = print(head, 0)
    IO.puts("F1: " <> str)
    head
  end

  def get_element_at([_head | tail], index) when index > 0 do
    str = print(tail, index)
    IO.puts("F2: " <> str)

    get_element_at(
      tail,
      index - 1
    )
  end

  # def get_element_at([], index) do
  #   str = print([], index)
  #   IO.puts("F3: " <> str)
  #   nil
  # end

  def print(list, index) do
    str =
      "List: " <>
        inspect(list, pretty: true) <>
        ", Index: " <> Integer.to_string(index - 1)

    str
  end
end
