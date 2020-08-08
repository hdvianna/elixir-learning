defmodule Discuss.AuthController do
  use Discuss.Web, :controller
  plug(Ueberauth)
  alias Discuss.User

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{"provider" => provider} = params) do
    user_params = %{
      token: auth.credentials.token,
      email: auth.info.email,
      provider: provider
    }

    changeset = User.changeset(%User{}, user_params)
    signin(conn, changeset)
  end

  defp signin(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |>put_flash(:info, "Welcome back!")
        |>put_session(:user_id, user.id)
        |>redirect(to: topic_path(conn, :index))
      {:error, _reason} ->
        conn
        |>put_flash(:error, "Error while signing in.")
        |>redirect(to: topic_path(conn, :index))
    end
  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)
      user ->
        changeset = User.changeset(user, %{
          token: changeset.changes.token,
          email: changeset.changes.email,
          provider: changeset.changes.provider
        })
        Repo.update(changeset)
    end
  end

  def signout(conn, changeset) do
    conn
    |>configure_session(drop: true)
    |>redirect(to: topic_path(conn, :index))
  end

end
