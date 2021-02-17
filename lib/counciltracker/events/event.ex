defmodule Counciltracker.Events.Event do
  @moduledoc """
  The Event schema
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Counciltracker.Authorities.Authority

  schema "events" do
    field(:occurred_on, :date)
    field(:type, Ecto.Enum, values: [:election, :change_of_affiliation, :co_option])
    belongs_to :authority, Authority

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:occurred_on, :type, :authority_id])
    |> validate_required([:occurred_on, :type, :authority_id])
  end
end
