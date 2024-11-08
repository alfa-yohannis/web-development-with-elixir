defmodule Hello.Temperature do
  use GenServer

  alias Phoenix.PubSub

  def init(init_arg) do
    {:ok, init_arg}
  end

  # Start the GenServer with an initial temperature of 70°F
  def start_link(_) do
    GenServer.start_link(__MODULE__, 70, name: __MODULE__)
  end

  # Public API to get the current temperature
  def get_temperature do
    GenServer.call(__MODULE__, :get_temperature)
  end

  # Public API to update the temperature
  def update_temperature(new_temperature) do
    GenServer.cast(__MODULE__, {:update_temperature, new_temperature})
  end

  # GenServer callback to handle getting temperature
  def handle_call(:get_temperature, _from, temperature) do
    {:reply, temperature, temperature}
  end

  # GenServer callback to handle updating temperature and broadcasting
  def handle_cast({:update_temperature, new_temperature}, _temperature) do
    PubSub.broadcast(Hello.PubSub, "temperature:updates", {:temperature_update, new_temperature})
    {:noreply, new_temperature}
  end
end
