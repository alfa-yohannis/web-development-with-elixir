# lib/my_app_web/live/modifiable_live.ex
defmodule HelloWeb.ModifiableLive do
  use HelloWeb, :live_view

  alias Hello.Temperature

  def mount(_params, _session, socket) do
    :ok = Phoenix.PubSub.subscribe(Hello.PubSub, "temperature:updates")
    temperature = Temperature.get_temperature()
    {:ok, assign(socket, :temperature, temperature)}
  end

  @spec handle_event(<<_::120>>, any(), map()) :: {:noreply, map()}
  def handle_event("inc_temperature", _params, socket) do
    new_temperature = socket.assigns.temperature + 1
    Temperature.update_temperature(new_temperature)
    {:noreply, assign(socket, :temperature, new_temperature)}
  end

  def handle_info({:temperature_update, new_temperature}, socket) do
    {:noreply, assign(socket, :temperature, new_temperature)}
  end
end
