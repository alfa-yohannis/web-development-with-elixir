hash = :crypto.hash(:md5, "wolverine")
IO.puts("hash = " <> Kernel.inspect(hash))

hash16 = Base.encode16(hash)
IO.puts("hash16 = " <> hash16)

list = :binary.bin_to_list(hash)
IO.puts("list = " <> Kernel.inspect(list))

hash = :crypto.hash(:md5, "superman")
IO.puts("hash = " <> Kernel.inspect(hash))

Code.require_file("avatar_image.ex", __DIR__)

defmodule AvatarGenerator do
  def generate(input) do
    input
    |> compute_hash
  end

  def compute_hash(input) do
   hash = :crypto.hash(:sha256, input)
   |> :binary.bin_to_list

   %Avatar.Image{hash: hash}
 end
 end

 result = AvatarGenerator.generate("banana")
 IO.inspect(result)
