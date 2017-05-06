defmodule CheckListApi.ProjectView do
  require Logger
  alias CheckListApi.ChecklistView
  use CheckListApi.Web, :view

  def render("index.json", %{projects: projects}) do
    Logger.debug "View: Projects: #{inspect projects}" 
    render_many(projects, CheckListApi.ProjectView, "project.json")
  end

  def render("project.json", %{project: project}) do
    Logger.debug "View: Project: #{inspect project}"
    checklists = ChecklistView.render("checklists.json", %{checklists: project.checklists})
    Logger.info "Checklists => #{inspect checklists}"  
    %{"name" => project.name, "id" => project.id, "checklists" => checklists}
  end
end
