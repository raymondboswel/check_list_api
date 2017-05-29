defmodule CheckListApi.UserView do
  require Logger
  alias CheckListApi.ProjectView
  use CheckListApi.Web, :view

  def render("index.json", %{users: users}) do
    Logger.debug "View: Users: #{inspect users}"
    render_many(users, CheckListApi.UserView, "user.json")
  end

  def render("sign_in.json", %{user: user, jwt: jwt, exp: exp}) do
    %{"user_id" => user.id, "jwt" => jwt, "exp" => exp}
  end

  def render("user.json", %{user: user}) do
    Logger.debug "View: User: #{inspect user}"
    projects = ProjectView.render("projects.json", %{projects: user.projects})
    Logger.info "Projects => #{inspect projects}"
    %{"first_name" => user.first_name, "last_name" => user.last_name, "email" => user.email, "id" => user.id, "projects" => projects}
  end
end
