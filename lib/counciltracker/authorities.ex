defmodule Counciltracker.Authorities do
  @moduledoc """
  The Authorities context.
  """

  import Ecto.Query, warn: false
  alias Counciltracker.Repo

  alias Counciltracker.Authorities.Authority

  def get_authority_by!(host: host) do
    query = from a in Authority, where: ^host in a.hosts, limit: 1
    query |> Repo.one()
  end

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
