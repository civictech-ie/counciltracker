defmodule Counciltracker.Plug.AuthoritySwitcher do
  import Plug.Conn

  @doc false
  def init(default), do: default

  @doc false
  def call(conn, router) do
    case conn.host do
      subdomain when byte_size(subdomain) > 0 ->
        conn
        |> router.call(router.init({}))

      _ ->
        conn
    end
  end
end
