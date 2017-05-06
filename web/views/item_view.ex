defmodule CheckListApi.ItemView do
  require Logger
  use CheckListApi.Web, :view

  def render("items.json", %{items: items}) do
    Logger.debug "View: Items: #{inspect items}"
    render_many(items, CheckListApi.ItemView, "item.json")
  end

  def render("item.json", %{item: item}) do
    Logger.debug "View: Item: #{inspect item}"
    %{"id" => item.id, "name" => item.name, "completed" => item.completed}
  end
end
