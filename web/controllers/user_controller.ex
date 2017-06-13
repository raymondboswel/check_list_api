defmodule CheckListApi.UserController do
  alias CheckListApi.Project
  alias CheckListApi.Checklist
  alias CheckListApi.User
  require Logger
  use CheckListApi.Web, :controller

  def index(conn, _params) do
    users = User |> Repo.all |> Repo.preload([:projects])
    Logger.debug "Users: #{inspect users}"
    render conn, "index.json", users: users
  end

  def create(conn, %{
                      "email" => email,
                      "password" => password} = params) do

    passwd_hash = Comeonin.Pbkdf2.hashpwsalt(password)

    user = Map.put(params, "passwd_hash", passwd_hash)
    changeset = User.changeset(%User{}, user)

    case Repo.insert(changeset) do
      {:ok, user} ->
        new_conn = Guardian.Plug.api_sign_in(conn, user)
        jwt = Guardian.Plug.current_token(new_conn)
        {:ok, claims} = Guardian.Plug.claims(new_conn)
        exp = Map.get(claims, "exp")
        conn
           |>  put_resp_header("authorization", "Bearer #{jwt}")
           |>  put_resp_header("x-expires", Integer.to_string(exp))
           |>  render "sign_in.json", user: user, jwt: jwt, exp: exp
      {:error, changeset} ->
        Logger.debug "Error adding user: #{inspect changeset}"
        conn
          |> send_resp(500, "")
    end
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    user = CheckListApi.Repo.get_by(User, email: email)
    auth_success = Comeonin.Pbkdf2.checkpw(password, user.passwd_hash)
    if auth_success do
      new_conn = Guardian.Plug.api_sign_in(conn, user)
      jwt = Guardian.Plug.current_token(new_conn)
      {:ok, claims} = Guardian.Plug.claims(new_conn)
      exp = Map.get(claims, "exp")

      new_conn
      |> put_resp_header("authorization", "Bearer #{jwt}")
      |> put_resp_header("x-expires", Integer.to_string(exp))
      |> render "sign_in.json", user: user, jwt: jwt, exp: exp
    else
      conn
          |> send_resp(401, "Could not authenticate with email/password")
    end
  end

  def delete(conn, %{"name" => name}) do
    project = Repo.get_by(Project, name: name)
    case Repo.delete project do
      {:ok, struct}       ->
        conn
        |> send_resp(201, struct.name)
      {:error, changeset} ->
        conn
        |> send_resp(500, "")
    end
  end

  def get_project(id) do
    CheckListApi.Repo.get(Project, id)
  end

end
