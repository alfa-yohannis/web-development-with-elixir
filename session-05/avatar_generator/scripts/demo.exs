hash = :crypto.hash(:md5, "wolverine")
IO.puts("hash = " <> Kernel.inspect(hash))

hash16 = Base.encode16(hash)
IO.puts("hash16 = " <> hash16)

list = :binary.bin_to_list(hash)
IO.puts("list = " <> Kernel.inspect(list))


[r, g, b | _tail ] = list
IO.puts("r, g, b  = " <> Kernel.inspect({r, g, b}))
aa = %{hash: list, color: nil}
bb = %{aa | color: {r, g, b}}
IO.puts("aa = " <> Kernel.inspect(aa))
IO.puts("bb = " <> Kernel.inspect(bb))

full_chunks_count = div(length(list), 3) * 3
full_list = Enum.take(list, full_chunks_count)
IO.puts("full_list = " <> Kernel.inspect(full_list))

chuncks = Enum.chunk_every(full_list, 3)
IO.puts("chuncks = " <> Kernel.inspect(chuncks))

reflected_rows = Enum.map(chuncks, fn row ->
    [ first, second | _tail] = row
    row ++ [second, first]
end)
IO.puts("reflected_rows = " <> Kernel.inspect(reflected_rows))

flatten_list = List.flatten(reflected_rows)
IO.puts("flatten_list = " <> Kernel.inspect(flatten_list))

indexed_list = Enum.with_index(flatten_list)
IO.puts("indexed_list = " <> Kernel.inspect(indexed_list))
