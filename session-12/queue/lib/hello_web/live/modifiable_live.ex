defmodule HelloWeb.ModifiableLive do
  use HelloWeb, :live_view
  alias Hello.QueueCounter
  alias Hello.Queue
  alias Hello.Repo

  def mount(params, session, socket) do
    # IO.puts("MOUNT:")
    # IO.inspect(session)
    %{"id" => queue_id} = params
    # %{"user_id" => user_id} = session

    case session do
      %{"user_id" => user_id} ->
        # Subscribe to updates from the QueueCounter
        :ok = Phoenix.PubSub.subscribe(Hello.PubSub, "queue_counter:updates")

        # Get the current number of cases handled from QueueCounter
        current_number = QueueCounter.get_current_number()

        queue = Repo.get!(Queue, queue_id)

        socket =
          socket
          |> assign(:current_number, current_number)
          |> assign(:queue_id, queue_id)
          |> assign(:user_id, user_id)
          |> assign(:queue, queue)

        {:ok, socket, layout: {HelloWeb.Layouts, :live}}

      _ ->
        socket =
          socket
          |> put_flash(:error, "You haven't signed in.")

        {:ok, push_navigate(socket, to: "/")}
    end
  end

  @spec handle_event(<<_::128>>, any(), map()) :: {:noreply, map()}
  def handle_event("increment_number", _params, socket) do
    # IO.puts("HANDLE EVENT:")
    # IO.inspect(socket)
    old_queue = Repo.get!(Queue, socket.assigns.queue_id)
    new_state = %{"current_number" => old_queue.current_number + 1}
    changeset = Queue.changeset(old_queue, new_state)
    Repo.update(changeset)

    current_queue = Repo.get!(Queue, socket.assigns.queue_id)

    # Increment the current number
    new_number = current_queue.current_number

    # Update QueueCounter with the new number
    QueueCounter.set_current_number(new_number)

    # Update the socket state with the new number
    {:noreply, assign(socket, :current_number, new_number)}
  end

  def handle_info({:number_update, new_number}, socket) do
    # Update the socket state when a new number is broadcasted
    {:noreply, assign(socket, :current_number, new_number)}
  end
end
