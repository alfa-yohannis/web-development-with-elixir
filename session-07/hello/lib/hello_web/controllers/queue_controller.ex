defmodule HelloWeb.QueueController do
  use HelloWeb, :controller

  def new(conn, _params) do
    render(conn, :new, layout: false)
  end

end
