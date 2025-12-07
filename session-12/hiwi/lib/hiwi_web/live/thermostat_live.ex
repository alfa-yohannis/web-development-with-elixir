defmodule HiwiWeb.ThermostatLive do
  use HiwiWeb, :live_view

  # def render(assigns) do
  #   ~H"""
  #   Current temperature: <%= @temperature %>°C
  # <button phx-click="inc_temperature" class="w-12  bg-cyan-500">+</button>
  #   """
  # end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :temperature, 30), layout: false}
  end

  def handle_event("inc_temperature", _params, socket) do
    {:noreply, update(socket, :temperature, &increase/1)}
  end

  defp increase(x) do
    x + 1
  end
end
