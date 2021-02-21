defmodule CounciltrackerWeb.AuthorityPicker do
  import Plug.Conn
  import Phoenix.Controller

  alias Counciltracker.Authorities
  alias CounciltrackerWeb.Router.Helpers, as: Routes

  def fetch_current_authority(conn, _opts) do
    authority = Authorities.get_authority_by!(host: conn.host)
    assign(conn, :current_authority, authority)
  end
end
