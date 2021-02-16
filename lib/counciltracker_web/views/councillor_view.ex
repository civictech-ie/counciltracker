defmodule CounciltrackerWeb.CouncillorView do
  use CounciltrackerWeb, :view
  alias CounciltrackerWeb.CouncillorView

  def render("bad_request.json", %{}) do
    %{error: "Bad request"}
  end

  def render("index.json", %{councillors: councillors}) do
    %{data: render_many(councillors, CouncillorView, "councillor.json")}
  end

  def render("show.json", %{councillor: councillor}) do
    %{data: render_one(councillor, CouncillorView, "councillor.json")}
  end

  def render("councillor.json", %{councillor: councillor}) do
    %{
      id: councillor.id,
      surname: councillor.surname,
      given_name: councillor.given_name,
      slug: councillor.slug
    }
  end
end
