defmodule Example.Application do
  use Application

  def start(_type, _args) do
    value = Example.get_element_at([9, 8, 3, 5, 1], 4)
    IO.puts("#{value}")
    IO.puts("Finished!")
    {:ok, self()}
  end
end
