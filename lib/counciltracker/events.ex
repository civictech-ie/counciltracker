defmodule Counciltracker.Events do
  @moduledoc """
  The Events context.
  """

  import Ecto.Query, warn: false
  alias Counciltracker.Repo

  alias Counciltracker.Authorities.Authority
  alias Counciltracker.Events.Event

  def list_events(%Authority{id: authority_id}) do
    from(Event, where: [authority_id: ^authority_id])
    |> Repo.all()
  end

  def list_unprocessed_events(%Authority{id: authority_id}) do
    from(e in Event,
      where:
        is_nil(e.processed_at) and
          e.authority_id ==
            ^authority_id
    )
    |> Repo.all()
  end

  def process!(%Authority{} = authority) do
    authority
    |> list_unprocessed_events
    |> Enum.each(&process_event!(&1))
  end

  defp process_event!(%Event{} = event) do
    event
    |> Event.process()
    |> Repo.transaction()
    |> case do
      {:ok, map} -> nil
      {:error, name, value, changes_so_far} -> nil
    end
  end
end
