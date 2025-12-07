defmodule HiwiWeb.DisplayOnlyLive do
  use HiwiWeb, :live_view
  alias Hiwi.QueueCounter
  alias Hiwi.Queue
  alias Hiwi.Repo

  @spec mount(map(), any(), map()) :: {:ok, map(), [{:layout, false}, ...]}
  def mount(params, _session, socket) do

    %{"id" => queue_id} = params

    # Subscribe to updates from the QueueCounter
    :ok = Phoenix.PubSub.subscribe(Hiwi.PubSub, "queue_counter:updates")

    # Get the initial current number of cases handled from QueueCounter
    current_number = QueueCounter.get_current_number()

    queue = Repo.get!(Queue, queue_id)

    socket =
      socket
      |> assign(:current_number, current_number)
      |> assign(:queue_name, queue.name)
      |> assign(:queue_prefix, queue.prefix)

    {:ok, socket, layout: false}
  end

  def handle_info({:number_update, new_number}, socket) do
    # Update the socket state when a new number is broadcasted
    {:noreply, assign(socket, :current_number, new_number)}
  end
end
