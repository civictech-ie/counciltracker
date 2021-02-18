defmodule Counciltracker.Events.Election do
  @moduledoc """
  The Election event
  """

  alias Ecto.Multi

  alias Counciltracker.Events.Event
  alias Counciltracker.Councillors.Councillor
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

  # defp process_councillor(multi, index, councillor_struct, %Event{
  #        authority_id: authority_id,
  #        occurred_on: occurred_on
  #      }) do
  #   multi
  #   |> Multi.append
  # end

  # defp insert_terms(
  #        multi,
  #        %Event{
  #          type: :election,
  #          authority_id: authority_id,
  #          parameters: %{"councillors" => councillors}
  #        } = event
  #      ) do
  #   councillors
  #   |> Enum.with_index()
  #   |> Enum.reduce(multi, fn {councillor, index}, multi ->
  #     multi |> insert_term(index, councillor, authority_id)
  #   end)
  # end

  # defp insert_term(multi, index, %{} = councillor, authority_id) do
  #   slug = "#{councillor["given_name"]}-#{councillor["surname"]}" |> String.to_atom()

  #   |> Multi.insert(
  #     {slug, :councillor},
  #     Councillor.changeset(%Councillor{}, %{
  #       given_name: councillor["given_name"],
  #       surname: councillor["surname"]
  #     })
  #   )
  #   |> Multi.insert(
  #     {slug, :term},
  #     fn %{{slug, :councillor} => %Councillor{id: councillor_id}} ->
  #       Term.changeset(%Term{}, %{
  #         councillor_id: councillor_id,
  #         authority_id: authority_id
  #       })
  #     end
  #   )
  # end
end
