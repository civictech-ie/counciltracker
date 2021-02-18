defmodule Counciltracker.TermsTest do
  use Counciltracker.DataCase

  alias Counciltracker.Terms

  describe "terms" do
    alias Counciltracker.Terms.Term

    @valid_attrs %{ends_on: ~D[2010-04-17], starts_on: ~D[2010-04-17]}
    @update_attrs %{ends_on: ~D[2011-05-18], starts_on: ~D[2011-05-18]}
    @invalid_attrs %{ends_on: nil, starts_on: nil}

    def term_fixture(attrs \\ %{}) do
      {:ok, term} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Terms.create_term()

      term
    end

    test "list_terms/0 returns all terms" do
      term = term_fixture()
      assert Terms.list_terms() == [term]
    end

    test "get_term!/1 returns the term with given id" do
      term = term_fixture()
      assert Terms.get_term!(term.id) == term
    end

    test "create_term/1 with valid data creates a term" do
      assert {:ok, %Term{} = term} = Terms.create_term(@valid_attrs)
      assert term.ends_on == ~D[2010-04-17]
      assert term.starts_on == ~D[2010-04-17]
    end

    test "create_term/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Terms.create_term(@invalid_attrs)
    end

    test "update_term/2 with valid data updates the term" do
      term = term_fixture()
      assert {:ok, %Term{} = term} = Terms.update_term(term, @update_attrs)
      assert term.ends_on == ~D[2011-05-18]
      assert term.starts_on == ~D[2011-05-18]
    end

    test "update_term/2 with invalid data returns error changeset" do
      term = term_fixture()
      assert {:error, %Ecto.Changeset{}} = Terms.update_term(term, @invalid_attrs)
      assert term == Terms.get_term!(term.id)
    end

    test "delete_term/1 deletes the term" do
      term = term_fixture()
      assert {:ok, %Term{}} = Terms.delete_term(term)
      assert_raise Ecto.NoResultsError, fn -> Terms.get_term!(term.id) end
    end

    test "change_term/1 returns a term changeset" do
      term = term_fixture()
      assert %Ecto.Changeset{} = Terms.change_term(term)
    end
  end
end
