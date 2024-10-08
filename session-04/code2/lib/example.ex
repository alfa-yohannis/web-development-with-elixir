defmodule Example do
  def get_element_at([head | _tail], 0), do: head

  def get_element_at([_head | tail], index) when index > 0 do
    str = inspect(tail, pretty: true)
         <> " " <> Integer.to_string(index - 1)
    IO.puts(str)
    get_element_at(tail, index - 1)
  end

  def get_element_at([], _index), do: nil

end
