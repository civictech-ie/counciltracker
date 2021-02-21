defmodule CounciltrackerWeb.CouncillorController do
  use CounciltrackerWeb, :controller

  alias Counciltracker.Authorities
  alias Counciltracker.Councillors

  action_fallback CounciltrackerWeb.FallbackController

  def index(conn, %{"date" => date_str}) do
    case Date.from_iso8601(date_str) do
      {:ok, date} ->
        councillors = Councillors.list_councillors(date, conn.assigns.current_authority)

        render(conn, "index.json", councillors: councillors)

      _ ->
        render(conn, "bad_request.json")
    end
  end

  def index(conn, _params) do
    councillors = Councillors.list_councillors(conn.assigns.current_authority)
    render(conn, "index.json", councillors: councillors)
  end

  def show(conn, %{"slug" => slug}) do
    councillor = Councillors.get_councillor_by_slug!(slug, conn.assigns.current_authority)
    render(conn, "show.json", councillor: councillor)
  end
end
