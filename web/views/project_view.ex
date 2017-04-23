defmodule CheckListApi.ProjectView do
  use CheckListApi.Web, :view

  def render("index.json", %{projects: projects}) do
    render_many(projects, CheckListApi.ProjectView, "project.json")
  end

  def render("project.json", %{project: project}) do
    project
  end

  def render("checklists.json", %{checklists: checklists}) do
    render_many(checklists, CheckListApi.ProjectView, "checklist.json")
  end

  def render("checklist.json", %{checklist: checklist}) do
    checklist
  end
end
