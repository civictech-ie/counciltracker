defmodule CounciltrackerWeb.CouncillorControllerTest do
  use CounciltrackerWeb.ConnCase

  alias Counciltracker.Authorities
  alias Counciltracker.Authorities.Authority
  alias Counciltracker.Councillors
  alias Counciltracker.Councillors.Councillor

  @council_attrs %{
    name: "Dublin City Council"
  }

  @councillor_attrs %{
    given_name: "Hazel",
    surname: "Chu"
  }

  def fixture(:authority) do
    case Authorities.create_authority(@council_attrs) do
      {:ok, %Authority{} = authority} -> authority
    end
  end

  def fixture(:councillor) do
    authority = fixture(:authority)

    case Councillors.create_councillor(Map.put(@councillor_attrs, :authority_id, authority.id)) do
      {:ok, %Councillor{} = councillor} -> councillor
    end
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    setup [:create_authority]

    test "lists all councillors", %{conn: conn, authority: authority} do
      conn = get(conn, Routes.councillor_path(conn, :index))
      assert json_response(conn, 200)["data"] == []

      {:ok, councillor} = Councillors.create_councillor(authority, @councillor_attrs)

      conn = get(conn, Routes.councillor_path(conn, :index))

      assert [
               %{
                 "id" => id,
                 "slug" => slug
               }
             ] = json_response(conn, 200)["data"]

      assert [id, slug] == [councillor.id, councillor.slug]
    end

    test "lists all councillors on date", %{conn: conn, authority: authority} do
      conn = get(conn, Routes.councillor_path(conn, :index), %{date: "2020-01-01"})
      assert json_response(conn, 200)["data"] == []

      {:ok, councillor} = Councillors.create_councillor(authority, @councillor_attrs)

      conn = get(conn, Routes.councillor_path(conn, :index))

      assert [
               %{
                 "id" => id,
                 "slug" => slug
               }
             ] = json_response(conn, 200)["data"]

      assert [id, slug] == [councillor.id, councillor.slug]
    end
  end

  describe "show" do
    setup [:create_councillor, :create_authority]

    test "renders councillor when data is valid", %{
      conn: conn,
      councillor: %Councillor{id: id}
    } do
      conn = get(conn, Routes.councillor_path(conn, :show, id))

      assert %{
               "id" => _id,
               "given_name" => "Hazel",
               "surname" => "Chu",
               "slug" => "hazel-chu"
             } = json_response(conn, 200)["data"]
    end
  end

  defp create_councillor(_) do
    councillor = fixture(:councillor)
    %{councillor: councillor}
  end

  defp create_authority(_) do
    authority = fixture(:authority)
    %{authority: authority}
  end
end
