defmodule Example2 do

  def greet({first_name, last_name}) do
    "Hello, #{first_name} #{last_name}!"
  end

  def match_pattern(tuple) do
    case tuple do
      {1, x, 3 } -> IO.inspect("x = #{x}")
      {x, 2, 4, 6} -> IO.inspect("x = #{x}")
      _ -> IO.inspect("Tidak ada nilai")
    end
  end

  def multiply_and_add(x, y, z) do
    x * y + z
  end

  def string_to_integer(str) do
    String.to_integer(str)
  end

  def add_five(num) do
    num + 5
  end

  def write_file(filename, data) do
    File.write(filename, data)
  end

  def read_file(filename) do
    tmp = File.read(filename)
    IO.inspect(tmp)
    case tmp do
      {:ok, content} -> IO.inspect("File content: #{content}")
      {:error, reason} -> IO.inspect("Failed to read file: #{reason}")
    end
  end

  def save_json(filename, data) do
    File.write(filename, Jason.encode(data))
  end

  @spec load_json(
          binary()
          | maybe_improper_list(
              binary() | maybe_improper_list(any(), binary() | []) | char(),
              binary() | []
            )
        ) :: any()
  def load_json(filename) do
    tmp = File.read(filename)
    IO.inspect(tmp)
    case tmp do
      {:ok, content} ->
        case Jason.decode(content) do
          {:ok, decoded_data} -> IO.inspect("JSON content: #{decoded_data}")
          {:error, reason} -> IO.inspect("Failed to decode JSON: #{reason}")
        end
      {:error, reason} -> IO.inspect("Failed to read file: #{reason}")
    end
  end
end
