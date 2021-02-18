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

    test "change_councillor/1 returns a councillor changeset" do
      councillor = councillor_fixture()
      assert %Ecto.Changeset{} = Councillors.change_councillor(councillor)
    end
  end
end
