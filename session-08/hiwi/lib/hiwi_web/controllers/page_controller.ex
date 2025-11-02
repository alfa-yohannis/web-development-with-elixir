defmodule HiwiWeb.PageController do
  use HiwiWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
