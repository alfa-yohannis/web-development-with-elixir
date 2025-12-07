defmodule HiwiWeb.ModifiableLive do
  use HiwiWeb, :live_view
  alias Hiwi.QueueCounter
  alias Hiwi.Queue
  alias Hiwi.User
  alias Hiwi.Repo


  def mount(params, session, socket) do
    # IO.puts("MOUNT:")
    # IO.inspect(session)
    %{"id" => queue_id} = params
    # %{"user_id" => user_id} = session

    case session do
      %{"user_id" => user_id} ->
        IO.puts("SESSION:")
        IO.inspect(session)

        # Subscribe to updates from the QueueCounter
        :ok = Phoenix.PubSub.subscribe(Hiwi.PubSub, "queue_counter:updates:#{queue_id}")

        # Get the current number of cases handled from QueueCounter
        current_number = QueueCounter.get_current_number(queue_id)

        queue = Repo.get!(Queue, queue_id)

        user = Repo.get(User, user_id)
        IO.puts("User:")
        IO.inspect(user)

        socket =
          socket
          |> assign(:current_number, current_number)
          |> assign(:queue_id, queue_id)
          |> assign(:user_id, user_id)
          |> assign(:user, user)
          |> assign(:queue, queue)

        {:ok, socket, layout: {HiwiWeb.Layouts, :live}}

      _ ->
        socket =
          socket
          |> put_flash(:error, "You haven't signed in.")

        {:ok, push_navigate(socket, to: "/")}
    end
  end


  def handle_event("increment_number", _params, socket) do
    # IO.puts("HANDLE EVENT:")
    # IO.inspect(socket)

    queue_id = socket.assigns.queue_id
    old_queue = Repo.get!(Queue, socket.assigns.queue_id)
    new_state = %{"current_number" => old_queue.current_number + 1}
    changeset = Queue.changeset(old_queue, new_state)
    Repo.update(changeset)

    current_queue = Repo.get!(Queue, socket.assigns.queue_id)

    # Increment the current number
    new_number = current_queue.current_number

    # Update QueueCounter with the new number
    QueueCounter.set_current_number(queue_id, new_number)

    # Update the socket state with the new number
    socket =
      socket
      |> assign(:current_number, new_number)
      |> assign(:queue_id, queue_id)

    {:noreply,socket}
  end

  @spec handle_info({:number_update, any()}, map()) :: {:noreply, map()}
  def handle_info({:number_update, queue_id, new_number}, socket) do
    # Update the socket state when a new number is broadcasted
    socket =
      socket
      |> assign(:current_number, new_number)
      |> assign(:queue_id, queue_id)
    {:noreply,socket}
  end
end
