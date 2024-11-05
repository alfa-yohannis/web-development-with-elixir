defmodule HelloWeb.QueueController do
  use HelloWeb, :controller
  alias Hello.Queue
  alias Hello.Repo

  def index(conn, _params) do
    queues = Repo.all(Queue)
    render(conn, :index, queues: queues)
  end

  @spec new(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def new(conn, params) do
    sum = 1 + 1 + 9
    changeset = Queue.changeset(%Queue{}, %{})
    render(conn, :new, changeset: changeset, sum: sum)
  end

  def create(conn, params) do
    %{"queue" => queue_params} = params
    changeset = Queue.changeset(%Queue{}, queue_params)

    case Repo.insert(changeset) do
      {:ok, _queue} ->
        conn
        |> put_flash(:info, "Queue created successfully.")
        |> redirect(to: "/")

      {:error, changeset} ->
        IO.inspect(changeset)
        render(conn, :new, changeset: changeset)
    end
  end

  def edit(conn, params) do
    %{"id" => queue_id} = params

    queue = Repo.get(Queue, queue_id)

    IO.puts("AAAA = " <> Kernel.inspect(queue_id))

    changeset = Queue.changeset(queue, %{})

    render(conn, :edit, changeset: changeset, queue: queue)
  end

  def update(conn, params) do
    %{"id" => queue_id, "queue" => queue} = params

    old_queue = Repo.get(Queue, queue_id)
    changeset = Queue.changeset(old_queue, queue)

    case Repo.update(changeset) do
      {:ok, _queue} ->
        conn
        |> put_flash(:info, "Queue updated successfully.")
        |> redirect(to: "/")

      {:error, changeset} ->
        render(conn, :edit, changeset: changeset, queue: queue)
    end
  end

  def delete(conn, params) do
    %{"id" => queue_id} = params
    queue = Repo.get!(Queue, queue_id)
    result = Repo.delete!(queue)

    IO.puts("BBBX = " <> Kernel.inspect(result))

    conn
    |> put_flash(:info, "Queue deleted successfully.")
    |> redirect(to: "/")
  end
end
