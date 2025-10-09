defmodule Test do
  def wrap_in_brackets(prefix, content),
    do: prefix <> "[" <> content <> "]"
end

" world "
|> (&Test.wrap_in_brackets(&1, " Hello ")).()
|> IO.puts()
