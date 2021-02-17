defmodule Counciltracker.AuthoritiesTest do
  use Counciltracker.DataCase

  alias Counciltracker.Authorities

  describe "authorities" do
    alias Counciltracker.Authorities.Authority

    @valid_attrs %{name: "Dublin City Council"}
    @update_attrs %{name: "Sligo County Council"}
    @invalid_attrs %{name: nil}

    def authority_fixture(attrs \\ %{}) do
      {:ok, authority} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Authorities.create_authority()

      authority
    end

    test "list_authorities/0 returns all authorities" do
      authority = authority_fixture()
      assert Authorities.list_authorities() == [authority]
    end

    test "get_authority!/1 returns the authority with given id" do
      authority = authority_fixture()
      assert Authorities.get_authority!(authority.id) == authority
    end

    test "create_authority/1 with valid data creates a authority" do
      assert {:ok, %Authority{} = authority} = Authorities.create_authority(@valid_attrs)
      assert authority.name == "Dublin City Council"
    end

    test "create_authority/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Authorities.create_authority(@invalid_attrs)
    end

    test "update_authority/2 with valid data updates the authority" do
      authority = authority_fixture()

      assert {:ok, %Authority{} = authority} =
               Authorities.update_authority(authority, @update_attrs)

      assert authority.name == "Sligo County Council"
    end

    test "update_authority/2 with invalid data returns error changeset" do
      authority = authority_fixture()
      assert {:error, %Ecto.Changeset{}} = Authorities.update_authority(authority, @invalid_attrs)
      assert authority == Authorities.get_authority!(authority.id)
    end

    test "delete_authority/1 deletes the authority" do
      authority = authority_fixture()
      assert {:ok, %Authority{}} = Authorities.delete_authority(authority)
      assert_raise Ecto.NoResultsError, fn -> Authorities.get_authority!(authority.id) end
    end

    test "change_authority/1 returns a authority changeset" do
      authority = authority_fixture()
      assert %Ecto.Changeset{} = Authorities.change_authority(authority)
    end
  end
end
