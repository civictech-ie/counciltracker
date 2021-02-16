defmodule CounciltrackerWeb.PageController do
  use CounciltrackerWeb, :controller

  def home(conn, _params) do
    render(conn, "home.html")
  end
end
