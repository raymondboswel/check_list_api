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
                      "last_name" => last_name,
                      "email" => email,
                      "password" => password} = params) do

    passwd_hash = Comeonin.Pbkdf2.hashpwsalt(password)

    user = Map.put(params, "passwd_hash", passwd_hash)
    changeset = User.changeset(%User{}, user)

    case Repo.insert(changeset) do
      {:ok, project} ->
      json conn, %{"id": project.id}
      {:error, changeset} ->
        conn
          |> send_resp(500, "")
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
