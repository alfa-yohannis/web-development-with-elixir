defmodule HelloWeb.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller

  def init(_params) do
  end

  def call(conn, _params) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:error, "You haven't signed in.")
      |> redirect(to: "/")
      |> halt()
    end
  end
end
