defmodule CheckListApi.ProjectController do
  alias CheckListApi.Project
  alias CheckListApi.Checklist
  alias CheckListApi.Repo
  require Logger
  use CheckListApi.Web, :controller

  def index(conn, _params) do
    query = from p in Project
      
      
    projects = Project |> Repo.all |> Repo.preload([:checklists])  
    Logger.debug "Projects: #{inspect projects}"
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

  def checklists(conn, %{"id" => id}) do
    checklists = Repo.get_by(Checklist, project_id: id)
    case checklists do
      nil ->
        render conn, "checklists.json", checklists: []
      checklists ->
        render conn, "checklists.json", checklists: checklists  
    end
  end

  def new_checklist(conn, %{"id" => project_id, "name" => name}) do    
    changeset = Checklist.changeset(%Checklist{}, %{name: name, project_id: project_id})    
    checklist = Repo.insert!(changeset)
    Logger.debug "Checklist: #{inspect checklist}"
    json conn, %{"project_id" => project_id, "checklist" => %{"name" => checklist.name, "id" => checklist.id}} 
  end

  def get_project(id) do
    CheckListApi.Repo.get(Project, id)
  end

end
