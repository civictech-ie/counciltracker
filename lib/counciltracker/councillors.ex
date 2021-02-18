defmodule Counciltracker.Councillors do
  @moduledoc """
  The Councillors context.
  """

  import Ecto.Query, warn: false
  alias Counciltracker.Repo

  alias Counciltracker.Authorities.Authority
  alias Counciltracker.Councillors.Councillor

  def list_councillors(:current) do
    Councillor |> Repo.all() |> Repo.preload(:terms)
  end

  def get_councillor(slug: slug) do
    from(Councillor, where: [slug: ^slug], limit: 1)
    |> Repo.one()
  end

  def get_councillor!(id) do
    from(Councillor, where: [id: ^id], limit: 1)
    |> Repo.one!()
  end

  def change_councillor(%Councillor{} = councillor, attrs \\ %{}) do
    Councillor.changeset(councillor, attrs)
  end

  def create_councillor(%Authority{id: authority_id}, attrs) do
    %Councillor{}
    |> Councillor.changeset(attrs |> Enum.into(%{authority_id: authority_id}))
    |> Repo.insert()
  end

  def create_councillor(attrs \\ %{}) do
    %Councillor{}
    |> Councillor.changeset(attrs)
    |> Repo.insert()
  end
end
