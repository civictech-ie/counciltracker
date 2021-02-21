defmodule Counciltracker.Events.Event do
  @moduledoc """
  The Event schema
  """

  use Counciltracker.Schema
  import Ecto.Changeset

  alias Counciltracker.Authorities.Authority
  alias Counciltracker.Events.Election
  alias Counciltracker.Events.Event

  schema "events" do
    field :processed_at, :utc_datetime
    field :occurred_on, :date
    field :type, Ecto.Enum, values: [:election, :change_of_affiliation, :co_option]
    field :parameters, :map
    belongs_to :authority, Authority, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:occurred_on, :type, :authority_id, :parameters])
    |> validate_required([:occurred_on, :type, :authority_id])
  end

  @doc false
  def process_changeset(event, attrs) do
    event
    |> cast(attrs, [:processed_at])
    |> validate_required([:processed_at])
  end

  # Election
  # - upserts councillors
  # - upserts terms
  def process(%Event{type: :election} = event) do
    Election.process(event)
  end
end
