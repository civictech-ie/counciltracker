defmodule Counciltracker.Councillors.Councillor do
  use Ecto.Schema
  import Ecto.Changeset

  alias Counciltracker.Authorities.Authority

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "councillors" do
    field :given_name, :string
    field :slug, :string
    field :surname, :string
    belongs_to :authority, Authority

    timestamps()
  end

  @doc false
  def changeset(councillor, attrs) do
    councillor
    |> cast(Map.put(attrs, :slug, generate_slug(attrs)), [
      :authority_id,
      :surname,
      :given_name,
      :slug
    ])
    |> validate_required([:authority_id, :surname, :given_name, :slug])
  end

  defp generate_slug(%{given_name: "", surname: ""}), do: nil
  defp generate_slug(%{given_name: nil, surname: nil}), do: nil

  defp generate_slug(%{given_name: given_name, surname: surname})
       when is_binary(given_name) and is_binary(surname) do
    (given_name <> " " <> surname)
    |> String.trim()
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9\s-]/, "")
    |> String.replace(~r/(\s|-)+/, "-")
  end

  defp generate_slug(_params), do: nil
end
