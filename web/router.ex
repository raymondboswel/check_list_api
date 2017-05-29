defmodule CheckListApi.Router do
  use CheckListApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CheckListApi do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end


  scope "/api", CheckListApi do
    pipe_through :api
    get "/projects", ProjectController, :index
    post "/projects", ProjectController, :create
    delete "/projects", ProjectController, :delete

    get "/projects/:id/checklists", ChecklistController, :checklists
    post "/projects/:id/checklists", ChecklistController, :new_checklist
    delete "/checklists/:id", ChecklistController, :delete_checklist

    get "/checklists/:checklist_id/items", ItemController, :items
    post "/checklists/:checklist_id/items", ItemController, :new_item
    delete "/items/:id", ItemController, :delete_item
    put "/items/:id", ItemController, :update_item

    post "/users/", UserController, :create
    get "/users", UserController, :index
  end
end
