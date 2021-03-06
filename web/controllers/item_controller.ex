defmodule CheckListApi.ItemController do
  alias CheckListApi.Project
  alias CheckListApi.Item
  alias CheckListApi.Repo
  require Logger
  use CheckListApi.Web, :controller

  def items(conn, %{"checklist_id" => checklist_id}) do
    items = Repo.all(from i in Item,
                          where: i.checklist_id == ^checklist_id)
    case items do
      nil ->
        render conn, "items.json", items: []
      checklists ->
        render conn, "items.json", items: items  
    end
  end

  def new_item(conn, %{"checklist_id" => checklist_id, "name" => name, "completed" => completed} = params) do    
    changeset = Item.changeset(%Item{}, params)    
    item = Repo.insert!(changeset)
    Logger.debug "Item: #{inspect item}"
    json conn, %{"id" => item.id} 
  end

  def delete_item(conn, %{"id" => id}) do      
      item = CheckListApi.Repo.get(Item, id)      
      case CheckListApi.Repo.delete item do
      {:ok, struct}       -> 
        Logger.debug "Struct: #{inspect struct}"
        conn
        |> send_resp(200, Integer.to_string(struct.id))
      {:error, changeset} -> 
        Logger.error "Couldn't delete item"
        conn
        |> send_resp(500, "")
    end
  end

  def update_item(conn, %{"id" => id } = params) do
    item = Repo.get(Item, id)
    changeset = CheckListApi.Item.changeset(item, params)
    case CheckListApi.Repo.update(changeset) do
        {:ok, struct} ->
            conn
                |> send_resp(200, "")
        {:error, changeset} ->
            conn
                |> send_resp(500, "")
    end
  end

end