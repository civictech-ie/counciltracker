defmodule CounciltrackerWeb.EventView do
  use CounciltrackerWeb, :view
  alias CounciltrackerWeb.EventView

  def render("index.json", %{events: events}) do
    %{data: render_many(events, EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{id: event.id,
      occurred_on: event.occurred_on,
      type: event.type}
  end
end
