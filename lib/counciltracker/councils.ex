defmodule Counciltracker.Councils do
  @moduledoc """
  The Councils context.
  """

  import Ecto.Query, warn: false
  alias Counciltracker.Repo

  alias Counciltracker.Councils.Council

  def list_councils do
    Repo.all(Council)
  end

  def get_council!(:current), do: from(Council, limit: 1) |> Repo.one!()

  def get_council!(id), do: Repo.get!(Council, id)

  def create_council(attrs \\ %{}) do
    %Council{}
    |> Council.changeset(attrs)
    |> Repo.insert()
  end

  def update_council(%Council{} = council, attrs) do
    council
    |> Council.changeset(attrs)
    |> Repo.update()
  end

  def delete_council(%Council{} = council) do
    Repo.delete(council)
  end

  def change_council(%Council{} = council, attrs \\ %{}) do
    Council.changeset(council, attrs)
  end
end
