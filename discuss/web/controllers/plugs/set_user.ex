defmodule Discuss.Plugs.SetUser do
  import Plug.Conn #Helpers for working with conn objects
  import Phoenix.Controller

  alias Discuss.Repo
  alias Discuss.User

  def init(_params) do

  end

  def call(conn, _params) do
    user_id = get_session(conn, :user_id)

    cond do
        user = user_id && Repo.get(User, user_id) ->
          assign(conn, :user, user) # user will be put in conn.assigns
        true ->
          assign(conn, :user, nil)
    end

  end

end
