defmodule Counciltracker.Councillors do
  @moduledoc """
  The Councillors context.
  """

  import Ecto.Query, warn: false
  alias Counciltracker.Repo

  alias Counciltracker.Councils.Council
  alias Counciltracker.Councillors.Councillor

  def list_councillors(%Council{id: council_id}) do
    from(Councillor, where: [council_id: ^council_id])
    |> Repo.all()
  end

  def list_councillors(%Council{id: council_id}, %Date{} = date) do
    from(Councillor, where: [council_id: ^council_id])
    |> Repo.all()
  end

  def get_councillor!(%Council{id: council_id}, id) do
    from(Councillor, where: [id: ^id, council_id: ^council_id], limit: 1)
    |> Repo.one!()
  end

  def create_councillor(%Council{} = council, %{} = attrs) do
    %Councillor{}
    |> Councillor.changeset(Enum.into(attrs, %{council_id: council.id}))
    |> Repo.insert()
  end

  def create_councillor(attrs \\ %{}) do
    %Councillor{}
    |> Councillor.changeset(attrs)
    |> Repo.insert()
  end

  def update_councillor(%Councillor{} = councillor, attrs) do
    councillor
    |> Councillor.changeset(attrs)
    |> Repo.update()
  end

  def delete_councillor(%Councillor{} = councillor) do
    Repo.delete(councillor)
  end

  def change_councillor(%Councillor{} = councillor, attrs \\ %{}) do
    Councillor.changeset(councillor, attrs)
  end
end
