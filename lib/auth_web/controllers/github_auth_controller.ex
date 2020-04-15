defmodule AuthWeb.GithubAuthController do
  use AuthWeb, :controller

  @doc """
  `index/2` handles the callback from GitHub Auth API redirect.
  """
  def index(conn, %{"code" => code, "state" => state}) do
    {:ok, profile} = ElixirAuthGithub.github_auth(code)

    case not is_nil(state) and state =~ "//" do
      true -> # state = redirect
        url = state <> "?jwt=this.is.amaze"
        conn
        # |> put_req_header("authorization", "MY.JWT.HERE")
        |> redirect(external: url)
        # |> halt()
      false -> # no state
        conn
        |> put_view(AuthWeb.PageView)
        |> render(:welcome_github, profile: profile)
    end
  end

  def redirect_to_referer_with_jwt(conn, referer, person) do
    IO.inspect(conn, label: "conn")
    IO.inspect(referer, label: "referer")
    IO.inspect(person, label: "person")
  end
end
