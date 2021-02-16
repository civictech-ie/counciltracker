defmodule CounciltrackerWeb.CouncillorControllerTest do
  use CounciltrackerWeb.ConnCase

  alias Counciltracker.Councils
  alias Counciltracker.Councils.Council
  alias Counciltracker.Councillors
  alias Counciltracker.Councillors.Councillor

  @council_attrs %{
    name: "Dublin City Council"
  }

  @councillor_attrs %{
    given_name: "Hazel",
    surname: "Chu"
  }

  def fixture(:council) do
    case Councils.create_council(@council_attrs) do
      {:ok, %Council{} = council} -> council
    end
  end

  def fixture(:councillor) do
    council = fixture(:council)

    case Councillors.create_councillor(Map.put(@councillor_attrs, :council_id, council.id)) do
      {:ok, %Councillor{} = councillor} -> councillor
    end
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    setup [:create_council]

    test "lists all councillors", %{conn: conn, council: council} do
      conn = get(conn, Routes.councillor_path(conn, :index))
      assert json_response(conn, 200)["data"] == []

      {:ok, councillor} = Councillors.create_councillor(council, @councillor_attrs)

      conn = get(conn, Routes.councillor_path(conn, :index))

      assert [
               %{
                 "id" => id,
                 "slug" => slug
               }
             ] = json_response(conn, 200)["data"]

      assert [id, slug] == [councillor.id, councillor.slug]
    end

    test "lists all councillors on date", %{conn: conn, council: council} do
      conn = get(conn, Routes.councillor_path(conn, :index), %{date: "2020-01-01"})
      assert json_response(conn, 200)["data"] == []

      {:ok, councillor} = Councillors.create_councillor(council, @councillor_attrs)

      conn = get(conn, Routes.councillor_path(conn, :index))

      assert [
               %{
                 "id" => id,
                 "slug" => slug
               }
             ] = json_response(conn, 200)["data"]

      assert [id, slug] == [councillor.id, councillor.slug]
    end

    defp create_council(_) do
      council = fixture(:council)
      %{council: council}
    end
  end

  describe "show" do
    setup [:create_councillor, :create_council]

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

  defp create_council(_) do
    council = fixture(:council)
    %{council: council}
  end
end
