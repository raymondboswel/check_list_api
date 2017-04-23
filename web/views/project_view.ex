defmodule CheckListApi.ProjectView do
  use CheckListApi.Web, :view

  def render("index.json", %{projects: projects}) do
    render_many(projects, CheckListApi.ProjectView, "project.json")
  end

  def render("project.json", %{project: project}) do
    project
  end

end
