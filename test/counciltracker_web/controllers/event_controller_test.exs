defmodule CounciltrackerWeb.EventControllerTest do
  use CounciltrackerWeb.ConnCase

  alias Counciltracker.Events
  alias Counciltracker.Events.Event

  alias Counciltracker.Authorities
  alias Counciltracker.Authorities.Authority

  @authority_attrs %{
    name: "Dublin City Council"
  }

  @event_attrs %{
    occurred_on: ~D[2010-04-17],
    type: "election"
  }

  def fixture(:authority) do
    case Authorities.create_authority(@authority_attrs) do
      {:ok, %Authority{} = authority} -> authority
    end
  end

  def fixture(:event) do
    authority = fixture(:authority)

    case Events.create_event(authority, @event_attrs) do
      {:ok, %Event{} = event} -> event
    end
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    setup [:create_authority]

    test "lists all events", %{conn: conn} do
      conn = get(conn, Routes.event_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  defp create_authority(_) do
    authority = fixture(:authority)
    %{authority: authority}
  end
end
