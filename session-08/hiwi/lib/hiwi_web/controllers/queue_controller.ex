defmodule HiwiWeb.QueueController do
  use HiwiWeb, :controller
  alias Hiwi.Queue
  alias Hiwi.Repo

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

end
