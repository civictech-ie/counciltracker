defmodule CounciltrackerWeb.PageControllerTest do
  use CounciltrackerWeb.ConnCase

  alias Counciltracker.Authorities
  alias Counciltracker.Authorities.Authority

  @council_attrs %{
    name: "Dublin City Council",
    hosts: ["www.example.com"]
  }

  def fixture(:authority) do
    case Authorities.create_authority(@council_attrs) do
      {:ok, %Authority{} = authority} -> authority
    end
  end

  describe "home" do
    setup [:create_authority]

    test "GET /", %{conn: conn} do
      conn = get(conn, "/")
      assert html_response(conn, 200)
    end
  end

  defp create_authority(_) do
    authority = fixture(:authority)
    %{authority: authority}
  end
end
