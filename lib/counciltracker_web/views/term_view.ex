defmodule CounciltrackerWeb.TermView do
  use CounciltrackerWeb, :view
  alias CounciltrackerWeb.TermView

  def render("term.json", %{term: term}) do
    %{
      id: term.id,
      starts_on: term.starts_on,
      ends_on: term.ends_on
    }
  end
end
