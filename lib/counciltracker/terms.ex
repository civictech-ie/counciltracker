defmodule Counciltracker.Terms do
  @moduledoc """
  The Terms context.
  """

  import Ecto.Query, warn: false
  alias Counciltracker.Repo

  alias Counciltracker.Terms.Term

  def get_term!(id), do: Repo.get!(Term, id)

  def create_term(attrs \\ %{}) do
    %Term{}
    |> Term.changeset(attrs)
    |> Repo.insert()
  end

  def update_term(%Term{} = term, attrs) do
    term
    |> Term.changeset(attrs)
    |> Repo.update()
  end

  def delete_term(%Term{} = term) do
    Repo.delete(term)
  end

  def change_term(%Term{} = term, attrs \\ %{}) do
    Term.changeset(term, attrs)
  end
end
