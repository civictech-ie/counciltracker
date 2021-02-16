defmodule Counciltracker.CouncillorsTest do
  use Counciltracker.DataCase

  alias Counciltracker.Councils
  alias Counciltracker.Councils.Council
  alias Counciltracker.Councillors

  describe "councillors" do
    alias Counciltracker.Councillors.Councillor

    @council_attrs %{name: "Dublin City Council"}
    @valid_attrs %{given_name: "Joe", surname: "Costello"}
    @update_attrs %{given_name: "Tara", surname: "Deacy"}
    @invalid_attrs %{given_name: nil, surname: nil}

    def council_fixture(attrs \\ %{}) do
      {:ok, council} =
        attrs
        |> Enum.into(@council_attrs)
        |> Councils.create_council()

      council
    end

    def councillor_fixture(attrs \\ %{}) do
      council = council_fixture()

      {:ok, councillor} =
        attrs
        |> Enum.into(%{council_id: council.id})
        |> Enum.into(@valid_attrs)
        |> Councillors.create_councillor()

      councillor
    end

    test "list_councillors/0 returns all councillors" do
      councillor = councillor_fixture()
      council = Councils.get_council!(councillor.council_id)
      assert Councillors.list_councillors(council) == [councillor]
    end

    test "list_councillors/1 returns all councillors on a given date" do
      councillor = councillor_fixture()
      council = Councils.get_council!(councillor.council_id)
      date = ~D[2020-01-01]
      assert Councillors.list_councillors(council, date) != [councillor]
    end

    test "get_councillor!/1 returns the councillor with given id" do
      councillor = councillor_fixture()
      council = Councils.get_council!(councillor.council_id)

      assert Councillors.get_councillor!(council, councillor.id) == councillor
    end

    test "create_councillor/1 with valid data creates a councillor" do
      {:ok, %Council{} = council} = Councils.create_council(@council_attrs)

      assert {:ok, %Councillor{} = councillor} =
               Councillors.create_councillor(council, @valid_attrs)

      assert councillor.given_name == "Joe"
      assert councillor.surname == "Costello"
      assert councillor.slug == "joe-costello"
    end

    test "create_councillor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Councillors.create_councillor(@invalid_attrs)
    end

    test "update_councillor/2 with valid data updates the councillor" do
      councillor = councillor_fixture()

      assert {:ok, %Councillor{} = councillor} =
               Councillors.update_councillor(councillor, @update_attrs)

      assert councillor.given_name == "Tara"
      assert councillor.surname == "Deacy"
      assert councillor.slug == "tara-deacy"
    end

    test "update_councillor/2 with invalid data returns error changeset" do
      councillor = councillor_fixture()
      council = Councils.get_council!(councillor.council_id)

      assert {:error, %Ecto.Changeset{}} =
               Councillors.update_councillor(councillor, @invalid_attrs)

      assert councillor == Councillors.get_councillor!(council, councillor.id)
    end

    test "delete_councillor/1 deletes the councillor" do
      councillor = councillor_fixture()

      assert {:ok, %Councillor{}} = Councillors.delete_councillor(councillor)

      assert_raise Ecto.NoResultsError, fn ->
        council = Councils.get_council!(councillor.council_id)
        Councillors.get_councillor!(council, councillor.id)
      end
    end

    test "change_councillor/1 returns a councillor changeset" do
      councillor = councillor_fixture()
      assert %Ecto.Changeset{} = Councillors.change_councillor(councillor)
    end
  end
end
