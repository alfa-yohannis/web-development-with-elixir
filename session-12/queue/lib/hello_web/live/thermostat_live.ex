defmodule HelloWeb.ThermostatLive do
  use HelloWeb, :live_view

  def render(assigns) do
    ~H"""
    Current temperature: <%= @temperature %>°C
    <button phx-click="inc_temperature">+</button>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :temperature, 30)}
  end

  def handle_event("inc_temperature", _params, socket) do
    {:noreply, update(socket, :temperature, &(&1 + 1))}
  end
end
