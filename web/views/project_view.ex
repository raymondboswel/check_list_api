defmodule CheckListApi.ProjectView do
  require Logger
  use CheckListApi.Web, :view

  def render("index.json", %{projects: projects}) do
    Logger.debug "View: Projects: #{inspect projects}" 
    render_many(projects, CheckListApi.ProjectView, "project.json")
  end

  def render("project.json", %{project: project}) do
    %{"name" => project.name, "id" => project.id, "checklists" => render("checklists.json", %{checklists: project.checklists})}
  end

  def render("checklists.json", %{checklists: checklists}) do
    render_many(checklists, CheckListApi.ProjectView, "checklist.json")
  end

  def render("checklist.json", %{checklist: checklist}) do
    checklist
  end
end
