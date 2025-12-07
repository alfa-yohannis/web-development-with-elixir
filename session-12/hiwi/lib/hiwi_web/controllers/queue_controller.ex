defmodule HiwiWeb.QueueController do
  use HiwiWeb, :controller
  alias Hiwi.Queue
  alias Hiwi.Repo

  plug HiwiWeb.Plugs.RequireAuth when action in [:new, :create, :update, :edit, :delete]
  plug :check_queue_owner when action in [:update, :edit, :delete]

  def index(conn, _params) do
    queues = Repo.all(Queue)
    render(conn, :index, queues: queues)
  end

  def new(conn, _params) do
    sum = 1 + 1 + 9
    changeset = Queue.changeset(%Queue{}, %{})
    render(conn, :new, changeset: changeset, sum: sum)
  end

  def create(conn, params) do
    %{"queue" => queue_params} = params
    # changeset = Queue.changeset(%Queue{}, queue_params)

    changeset =
      conn.assigns.user
      |> Ecto.build_assoc(:queues)
      |> Queue.changeset(queue_params)

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

  def show(conn, %{"id" => id}) do
    queue = Repo.get!(Queue, id)
    render(conn, :show, queue: queue)
  end

  def edit(conn, params) do
    %{"id" => queue_id} = params
    queue = Repo.get(Queue, queue_id)
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
    _result = Repo.delete!(queue)
    conn
    |> put_flash(:info, "Queue deleted successfully.")
    |> redirect(to: "/")
  end

  def check_queue_owner(conn, _params) do
    %{params: %{"id" => queue_id}} = conn

    if Repo.get(Queue, queue_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "The document is not editable")
      |> halt()
    end
  end
end
