defmodule CheckListApi.PageController do
  use CheckListApi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
