defmodule CheckListApi.ProjectController do
  alias CheckListApi.Project
  alias CheckListApi.Repo
  use CheckListApi.Web, :controller

  def index(conn, _params) do
    query = from p in Project,
     select: p.name
    projects = Repo.all(query)
    render conn, "index.json", projects: projects
  end

  def create(conn, %{"name" => name} = params) do
    changeset = Project.changeset(%Project{}, params)

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


end
