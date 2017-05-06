defmodule CheckListApi.ChecklistController do
  alias CheckListApi.Project
  alias CheckListApi.Checklist
  alias CheckListApi.Repo
  require Logger
  use CheckListApi.Web, :controller

  def checklists(conn, %{"id" => id}) do
    checklists = Repo.all(from c in Checklist,
                          where: c.project_id == ^id)
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
    json conn, %{"id" => checklist.id} 
  end

  def delete_checklist(conn, %{"id" => id}) do      
      checklist = CheckListApi.Repo.get(Checklist, id)      
      case CheckListApi.Repo.delete checklist do
      {:ok, struct}       -> 
        Logger.debug "Struct: #{inspect struct}"
        conn
        |> send_resp(200, Integer.to_string(struct.id))
      {:error, changeset} -> 
        Logger.error "Couldn't delete checklist"
        conn
        |> send_resp(500, "")
    end
  end

end