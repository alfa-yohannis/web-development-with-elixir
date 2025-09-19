# # [a, b, c] = [1, 2, 3]

defmodule Example do
	def hello(prefix, name) do
	  prefix <> name
	end
end

defmodule FileReader do
  def write_file(filename, content) do
    File.write(filename, content)
  end

  def read_file(filename) do
    case File.read(filename) do
      {:ok, content} ->
        IO.puts("File content: #{content}")
      {:error, reason} ->
        IO.puts("Failed to read file: #{reason}")
    end
  end
end

# File: lib/json_file_handler.ex

defmodule JsonFileHandler do
  # Save data to a JSON file
  def save_json(filename, data) do
    File.write(filename, Jason.encode!(data))
  end

  # Load data from a JSON file
  def load_json(filename) do
    case File.read(filename) do
      {:ok, content} ->
        case Jason.decode(content) do
          {:ok, decoded_data} ->
            IO.inspect(decoded_data)
          {:error, reason} ->
            IO.puts("Failed to decode JSON: #{reason}")
        end
      {:error, reason} ->
        IO.puts("Failed to read file: #{reason}")
    end
  end
end
