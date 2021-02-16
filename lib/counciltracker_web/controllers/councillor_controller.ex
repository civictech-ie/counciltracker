defmodule CounciltrackerWeb.CouncillorController do
  use CounciltrackerWeb, :controller

  alias Counciltracker.Councils
  alias Counciltracker.Councillors
  alias Counciltracker.Councillors.Councillor

  action_fallback CounciltrackerWeb.FallbackController

  def index(conn, %{"date" => date_str}) do
    case Date.from_iso8601(date_str) do
      {:ok, date} ->
        councillors = Councillors.list_councillors(current_council(), date)
        render(conn, "index.json", councillors: councillors)

      _ ->
        render(conn, "bad_request.json")
    end
  end

  def index(conn, _params) do
    councillors = Councillors.list_councillors(current_council())
    render(conn, "index.json", councillors: councillors)
  end

  def show(conn, %{"id" => id}) do
    councillor = Councillors.get_councillor!(current_council(), id)
    render(conn, "show.json", councillor: councillor)
  end

  defp current_council do
    Councils.get_council!(:current)
  end
end
