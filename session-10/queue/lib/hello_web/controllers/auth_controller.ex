defmodule HelloWeb.AuthController do
  use HelloWeb, :controller
  plug Ueberauth
  alias Hello.User
  alias Hello.Repo

  def callback(conn, params) do
    IO.puts("AAAAAA")
    IO.inspect(conn)
    IO.puts("BBBBBB")
    IO.inspect(params)
    IO.puts("CCCCCC")
    %{"code" => _code, "provider" => provider, "state" => _state} = params
    %{assigns: %{ueberauth_auth: auth}} = conn
    %{credentials: %{token: token}, info: %{email: email, nickname: nickname}} = auth

    user_params = %{
      token: token,
      email: email || nickname,
      provider: provider
    }

    IO.puts("DDDDD")
    IO.inspect(user_params)

    changeset = User.changeset(%User{}, user_params)

    signin(conn, changeset)
  end

  defp signin(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Good to see you again!")
        |> put_session(:user_id, user.id)
        |> redirect(to: "/")
      {:error, reason} ->
        conn
          |> put_flash(:error, "Error when signing in: #{reason}")
          |> redirect(to: "/")
    end
  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)
      user ->
        {:ok, user}
    end
  end
end
