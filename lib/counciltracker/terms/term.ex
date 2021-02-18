defmodule Counciltracker.Terms.Term do
  @moduledoc """
  The Term schema -- the relationship between a councillor and an authority
  """

  use Counciltracker.Schema
  import Ecto.Changeset

  schema "terms" do
    field :ends_on, :date
    field :starts_on, :date
    belongs_to :authority, Authority, type: :binary_id
    belongs_to :councillor, Councillor, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(term, attrs) do
    term
    |> cast(attrs, [:starts_on, :ends_on, :authority_id, :councillor_id])
    |> validate_required([:starts_on, :authority_id, :councillor_id])
  end
end
