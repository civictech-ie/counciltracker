defmodule Counciltracker.Authorities.Authority do
  @moduledoc """
  The Authority schema
  """

  use Counciltracker.Schema
  import Ecto.Changeset

  alias Counciltracker.Terms.Term
  alias Counciltracker.Events.Event
  alias Counciltracker.Councillors.Councillor

  schema "authorities" do
    field :name, :string
    has_many :events, Event
    has_many :terms, Term
    has_many :councillors, through: [:terms, :councillors]

    timestamps()
  end

  @doc false
  def changeset(authority, attrs) do
    authority
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
