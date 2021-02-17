defmodule Counciltracker.CouncillorsTest do
  use Counciltracker.DataCase

  alias Counciltracker.Authorities
  alias Counciltracker.Authorities.Authority
  alias Counciltracker.Councillors

  describe "councillors" do
    alias Counciltracker.Councillors.Councillor

    @authority_attrs %{name: "Dublin City Council"}
    @valid_attrs %{given_name: "Joe", surname: "Costello"}
    @update_attrs %{given_name: "Tara", surname: "Deacy"}
    @invalid_attrs %{given_name: nil, surname: nil}

    def authority_fixture(attrs \\ %{}) do
      {:ok, authority} =
        attrs
        |> Enum.into(@authority_attrs)
        |> Authorities.create_authority()

      authority
    end

    def councillor_fixture(attrs \\ %{}) do
      authority = authority_fixture()

      {:ok, councillor} =
        attrs
        |> Enum.into(%{authority_id: authority.id})
        |> Enum.into(@valid_attrs)
        |> Councillors.create_councillor()

      councillor
    end

    test "list_councillors/1 returns all councillors for an authority today" do
      councillor = councillor_fixture()
      authority = Authorities.get_authority!(councillor.authority_id)
      assert Councillors.list_councillors(authority) == [councillor]
    end

    test "list_councillors/2 returns all councillors for an authority on a given date" do
      councillor = councillor_fixture()
      authority = Authorities.get_authority!(councillor.authority_id)
      date = ~D[2020-01-01]
      assert Councillors.list_councillors(authority, date) != [councillor]
    end

    test "get_councillor!/2 returns the councillor with given id" do
      councillor = councillor_fixture()
      authority = Authorities.get_authority!(councillor.authority_id)

      assert Councillors.get_councillor!(authority, councillor.id) == councillor
    end

    test "create_councillor/2 with valid data creates a councillor" do
      {:ok, %Authority{} = authority} = Authorities.create_authority(@authority_attrs)

      assert {:ok, %Councillor{} = councillor} =
               Councillors.create_councillor(authority, @valid_attrs)

      assert councillor.given_name == "Joe"
      assert councillor.surname == "Costello"
      assert councillor.slug == "joe-costello"
    end

    test "create_councillor/1 with invalid data returns error changeset" do
      {:ok, %Authority{} = authority} = Authorities.create_authority(@authority_attrs)

      assert {:error, %Ecto.Changeset{}} =
               Councillors.create_councillor(authority, @invalid_attrs)
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
      authority = Authorities.get_authority!(councillor.authority_id)

      assert {:error, %Ecto.Changeset{}} =
               Councillors.update_councillor(councillor, @invalid_attrs)

      assert councillor == Councillors.get_councillor!(authority, councillor.id)
    end

    test "delete_councillor/1 deletes the councillor" do
      councillor = councillor_fixture()

      assert {:ok, %Councillor{}} = Councillors.delete_councillor(councillor)

      assert_raise Ecto.NoResultsError, fn ->
        authority = Authorities.get_authority!(councillor.authority_id)
        Councillors.get_councillor!(authority, councillor.id)
      end
    end

    test "change_councillor/1 returns a councillor changeset" do
      councillor = councillor_fixture()
      assert %Ecto.Changeset{} = Councillors.change_councillor(councillor)
    end
  end
end
