defmodule HiwiWeb.AuthController do
  use HiwiWeb, :controller
  plug Ueberauth
  alias Hiwi.User
  alias Hiwi.Repo

  def callback(conn, params) do
    %{"code" => _code, "provider" => provider, "state" => _state} = params
    %{assigns: %{ueberauth_auth: auth}} = conn
    %{credentials: %{token: token}, info: %{email: email, nickname: nickname}} = auth

    user_params = %{
      token: token,
      email: email || nickname,
      provider: provider
    }

    changeset = User.changeset(%User{}, user_params)

    signin(conn, changeset)
  end

  def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> put_flash(:info, "Signout has been successful.")
    |> redirect(to: "/")
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
