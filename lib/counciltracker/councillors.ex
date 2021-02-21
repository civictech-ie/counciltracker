defmodule Counciltracker.Councillors do
  @moduledoc """
  The Councillors context.
  """

  import Ecto.Query, warn: false
  alias Counciltracker.Repo

  alias Counciltracker.Authorities.Authority
  alias Counciltracker.Councillors.Councillor
  alias Counciltracker.Terms.Term

  def list_councillors(%Authority{} = authority) do
    query =
      from c in Councillor,
        join: t in Term,
        on: c.id == t.councillor_id,
        where: t.authority_id == ^authority.id

    query |> Repo.all() |> Repo.preload(:terms)
  end

  def list_councillors(:current, %Authority{} = authority) do
    list_councillors(Date.utc_today(), authority)
  end

  def list_councillors(%Date{} = date, %Authority{} = authority) do
    query =
      from c in Councillor,
        join: t in Term,
        on: c.id == t.councillor_id,
        where:
          t.authority_id == ^authority.id and t.starts_on < ^date and
            (is_nil(t.ends_on) or t.ends_on > ^date)

    query |> Repo.all() |> Repo.preload(:terms)
  end

  def get_councillor_by_slug!(slug, %Authority{} = authority) do
    query =
      from c in Councillor,
        join: t in Term,
        on: c.id == t.councillor_id,
        where: t.authority_id == ^authority.id and c.slug == ^slug

    query |> Repo.one() |> Repo.preload(:terms)
  end

  def get_councillor_by_id!(id, %Authority{} = authority) do
    query =
      from c in Councillor,
        join: t in Term,
        on: c.id == t.councillor_id,
        where: t.authority_id == ^authority.id and c.id == ^id

    query |> Repo.one() |> Repo.preload(:terms)
  end

  def change_councillor(%Councillor{} = councillor, attrs \\ %{}) do
    Councillor.changeset(councillor, attrs)
  end

  def create_councillor(attrs) do
    %Councillor{}
    |> Councillor.changeset(attrs)
    |> Repo.insert()
  end
end
