defmodule Hello.QueueCounter do
  use GenServer

  alias Phoenix.PubSub

  # Initialize with an empty map to store queue numbers
  def init(initial_map_state) do
    IO.puts("## initial_map_state")
    IO.inspect(initial_map_state)
    {:ok, initial_map_state}
  end

  # Start the GenServer with an empty map
  def start_link(_) do
    start_link_initial_map_state = %{}
    IO.puts("## start_link_initial_map_state")
    IO.inspect(start_link_initial_map_state)
    GenServer.start_link(__MODULE__, start_link_initial_map_state, name: __MODULE__)
  end

  # Public API to get the current number for a specific queue_id
  def get_current_number(queue_id) do
    GenServer.call(__MODULE__, {:get_current_number, queue_id})
  end

  # Public API to set the current number for a specific queue_id
  def set_current_number(queue_id, new_number) do
    GenServer.cast(__MODULE__, {:set_current_number, queue_id, new_number})
  end

  # Handle getting the current number for a queue_id
  def handle_call({:get_current_number, queue_id}, _from, current_map_state) do

    IO.puts("## current_map_state")
    IO.inspect(current_map_state)

    # Default to 0 if queue_id is not found
    current_number = Map.get(current_map_state, queue_id, 0)
    {:reply, current_number, current_map_state}
  end

  # Handle setting the current number for a queue_id and broadcasting the update
  def handle_cast({:set_current_number, queue_id, new_number}, current_map_state) do
    updated_map_state = Map.put(current_map_state, queue_id, new_number)

    PubSub.broadcast(
      Hello.PubSub,
      "queue_counter:updates:#{queue_id}",
      {:number_update, queue_id, new_number}
    )

    {:noreply, updated_map_state}
  end
end
