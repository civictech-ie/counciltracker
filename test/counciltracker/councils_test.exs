defmodule Counciltracker.CouncilsTest do
  use Counciltracker.DataCase

  alias Counciltracker.Councils

  describe "councils" do
    alias Counciltracker.Councils.Council

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def council_fixture(attrs \\ %{}) do
      {:ok, council} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Councils.create_council()

      council
    end

    test "list_councils/0 returns all councils" do
      council = council_fixture()
      assert Councils.list_councils() == [council]
    end

    test "get_council!/1 returns the council with given id" do
      council = council_fixture()
      assert Councils.get_council!(council.id) == council
    end

    test "create_council/1 with valid data creates a council" do
      assert {:ok, %Council{} = council} = Councils.create_council(@valid_attrs)
      assert council.name == "some name"
    end

    test "create_council/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Councils.create_council(@invalid_attrs)
    end

    test "update_council/2 with valid data updates the council" do
      council = council_fixture()
      assert {:ok, %Council{} = council} = Councils.update_council(council, @update_attrs)
      assert council.name == "some updated name"
    end

    test "update_council/2 with invalid data returns error changeset" do
      council = council_fixture()
      assert {:error, %Ecto.Changeset{}} = Councils.update_council(council, @invalid_attrs)
      assert council == Councils.get_council!(council.id)
    end

    test "delete_council/1 deletes the council" do
      council = council_fixture()
      assert {:ok, %Council{}} = Councils.delete_council(council)
      assert_raise Ecto.NoResultsError, fn -> Councils.get_council!(council.id) end
    end

    test "change_council/1 returns a council changeset" do
      council = council_fixture()
      assert %Ecto.Changeset{} = Councils.change_council(council)
    end
  end
end
