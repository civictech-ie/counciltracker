defmodule CounciltrackerWeb.AuthorityPicker do
  @moduledoc """
  The Authority Picker takes a conn's host, assigns an authority, returns the conn.
  """

  import Plug.Conn
  import Phoenix.Controller

  alias Counciltracker.Authorities
  alias CounciltrackerWeb.Router.Helpers, as: Routes

  def fetch_current_authority(conn, _opts) do
    authority = Authorities.get_authority_by!(host: conn.host)
    assign(conn, :current_authority, authority)
  end
end
