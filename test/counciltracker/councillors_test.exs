defmodule Counciltracker.CouncillorsTest do
  use Counciltracker.DataCase

  alias Counciltracker.Authorities
  alias Counciltracker.Councillors
  alias Counciltracker.Councillors.Councillor
  alias Counciltracker.Terms

  describe "councillors" do
    @authority_attrs %{name: "Dublin City Council", hosts: ["www.example.com"]}
    @councillor_attrs %{given_name: "Joe", surname: "Costello"}

    test "list_councillors/1" do
      {:ok, councillor} = Councillors.create_councillor(@councillor_attrs)
      {:ok, authority} = Authorities.create_authority(@authority_attrs)

      assert Councillors.list_councillors(authority) == []

      {:ok, term} =
        Terms.create_term(%{
          councillor_id: councillor.id,
          authority_id: authority.id,
          starts_on: past_date()
        })

      councillor_ids = Councillors.list_councillors(authority) |> Enum.map(& &1.id)

      assert councillor_ids == [councillor.id]
    end

    test "list_councillors/2" do
      {:ok, councillor} = Councillors.create_councillor(@councillor_attrs)
      {:ok, authority} = Authorities.create_authority(@authority_attrs)

      assert Councillors.list_councillors(:current, authority) == []

      {:ok, term} =
        Terms.create_term(%{
          councillor_id: councillor.id,
          authority_id: authority.id,
          starts_on: future_date()
        })

      councillor_ids = Councillors.list_councillors(:current, authority) |> Enum.map(& &1.id)

      assert !Enum.member?(councillor_ids, councillor.id)

      councillor_ids =
        Councillors.list_councillors(Date.add(future_date(), 1), authority) |> Enum.map(& &1.id)

      assert Enum.member?(councillor_ids, councillor.id)
    end

    defp past_date() do
      Date.add(Date.utc_today(), -365)
    end

    defp future_date() do
      Date.add(Date.utc_today(), 365)
    end
  end
end
