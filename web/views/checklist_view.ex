defmodule CheckListApi.ChecklistView do
  require Logger
  use CheckListApi.Web, :view

  def render("checklists.json", %{checklists: checklists}) do
    Logger.debug "View: Checklists: #{inspect checklists}"
    render_many(checklists, CheckListApi.ChecklistView, "checklist.json")
  end

  def render("checklist.json", %{checklist: checklist}) do
    Logger.debug "View: Checklist: #{inspect checklist}"
    %{"id" => checklist.id, "name" => checklist.name}
  end
end
