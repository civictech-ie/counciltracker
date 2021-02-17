defmodule Counciltracker.Authorities.Authority do
  @moduledoc """
  The Authority schema
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Counciltracker.Councillors.Councillor

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "authorities" do
    field :name, :string
    has_many :councillors, Councillor

    timestamps()
  end

  @doc false
  def changeset(authority, attrs) do
    authority
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
