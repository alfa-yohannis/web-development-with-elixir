# lib/my_app_web/live/display_only_live.ex
defmodule HelloWeb.DisplayOnlyLive do
  use HelloWeb, :live_view

  alias Hello.Temperature

  def mount(_params, _session, socket) do
    # Subscribe to temperature updates
    :ok = Phoenix.PubSub.subscribe(Hello.PubSub, "temperature:updates")

    # Set the initial temperature
    temperature = Temperature.get_temperature()
    {:ok, assign(socket, :temperature, temperature)}
  end

  def handle_info({:temperature_update, new_temperature}, socket) do
    {:noreply, assign(socket, :temperature, new_temperature)}
  end
end
