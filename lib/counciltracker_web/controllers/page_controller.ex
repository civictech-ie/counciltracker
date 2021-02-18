defmodule CounciltrackerWeb.PageController do
  use CounciltrackerWeb, :controller

  alias Counciltracker.Councillors

  def home(conn, _params) do
    councillors = Councillors.list_councillors(:current)
    render(conn, "home.html", councillors: councillors)
  end
end
