defmodule Counciltracker.Events.Election do
  @moduledoc """
  The Election event
  """

  alias Ecto.Multi

  alias Counciltracker.Councillors.Councillor
  alias Counciltracker.Events.Event
  alias Counciltracker.Terms.Term

  def process(%Event{type: :election} = event) do
    Multi.new()
    |> process_councillors(event)
    |> Multi.update(
      :mark_as_processed,
      Event.process_changeset(event, %{processed_at: DateTime.utc_now()})
    )
  end

  defp process_councillors(
         multi,
         %Event{
           type: :election,
           parameters: %{"councillors" => councillors}
         } = event
       ) do
    councillors
    |> Enum.with_index()
    |> Enum.reduce(multi, fn {councillor_struct, index}, multi ->
      multi
      |> insert_councillor(councillor_struct, index, event)
    end)
  end

  defp insert_councillor(multi, councillor_struct, index, %Event{
         authority_id: authority_id,
         occurred_on: occurred_on
       }) do
    councillor_key = "councillor_#{index}"
    term_key = "term_#{index}"

    multi
    |> Multi.insert(
      councillor_key,
      Councillor.changeset(%Councillor{}, %{
        given_name: councillor_struct["given_name"],
        surname: councillor_struct["surname"]
      })
    )
    |> Multi.insert(term_key, fn %{^councillor_key => %Councillor{id: councillor_id}} ->
      Term.changeset(%Term{}, %{
        authority_id: authority_id,
        councillor_id: councillor_id,
        starts_on: occurred_on
      })
    end)
  end
end
