defmodule Counciltracker.Councils.Council do
  use Ecto.Schema
  import Ecto.Changeset

  alias Counciltracker.Councillors.Councillor

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "councils" do
    field :name, :string
    has_many :councillors, Councillor

    timestamps()
  end

  @doc false
  def changeset(council, attrs) do
    council
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
