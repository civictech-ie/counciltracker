defmodule Counciltracker.Repo do
  use Ecto.Repo,
    otp_app: :counciltracker,
    adapter: Ecto.Adapters.Postgres
end
