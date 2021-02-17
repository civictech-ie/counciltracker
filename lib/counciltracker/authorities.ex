defmodule Counciltracker.Authorities do
  @moduledoc """
  The Authorities context.
  """

  import Ecto.Query, warn: false
  alias Counciltracker.Repo

  alias Counciltracker.Authorities.Authority

  def list_authorities do
    Repo.all(Authority)
  end

  def get_authority!(:current), do: from(Authority, limit: 1) |> Repo.one!()

  def get_authority!(id), do: Repo.get!(Authority, id)

  def create_authority(attrs \\ %{}) do
    %Authority{}
    |> Authority.changeset(attrs)
    |> Repo.insert()
  end

  def update_authority(%Authority{} = authority, attrs) do
    authority
    |> Authority.changeset(attrs)
    |> Repo.update()
  end

  def delete_authority(%Authority{} = authority) do
    Repo.delete(authority)
  end

  def change_authority(%Authority{} = authority, attrs \\ %{}) do
    Authority.changeset(authority, attrs)
  end
end
