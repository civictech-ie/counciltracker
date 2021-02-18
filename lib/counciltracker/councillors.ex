defmodule Counciltracker.Councillors do
  @moduledoc """
  The Councillors context.
  """

  import Ecto.Query, warn: false
  alias Counciltracker.Repo

  alias Counciltracker.Authorities.Authority
  alias Counciltracker.Councillors.Councillor

  def list_councillors(%Authority{id: authority_id}) do
    from(Councillor, where: [authority_id: ^authority_id])
    |> Repo.all()
  end

  def list_councillors(%Authority{id: authority_id}, %Date{} = date) do
    from(Councillor, where: [authority_id: ^authority_id])
    |> Repo.all()
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

  def get_councillor!(%Authority{id: authority_id}, id) do
    from(Councillor, where: [id: ^id, authority_id: ^authority_id], limit: 1)
    |> Repo.one!()
  end

  def change_councillor(%Councillor{} = councillor, attrs \\ %{}) do
    Councillor.changeset(councillor, attrs)
  end
end
