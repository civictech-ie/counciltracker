defmodule Counciltracker.AuthoritiesTest do
  use Counciltracker.DataCase

  alias Counciltracker.Authorities

  describe "authorities" do
    alias Counciltracker.Authorities.Authority

    @valid_attrs %{name: "Dublin City Council", hosts: ["localhost"]}
    @update_attrs %{name: "Sligo County Council", hosts: ["www.example.com"]}
    @invalid_attrs %{name: nil}

    def authority_fixture(attrs \\ %{}) do
      {:ok, authority} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Authorities.create_authority()

      authority
    end
  end
end
