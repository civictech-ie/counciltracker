defmodule CounciltrackerWeb.Router do
  use CounciltrackerWeb, :router

  import CounciltrackerWeb.AuthorityPicker

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_authority
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_current_authority
  end

  scope "/", CounciltrackerWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/api/", CounciltrackerWeb do
    pipe_through :api

    resources "/councillors", CouncillorController, only: [:show, :index]
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: CounciltrackerWeb.Telemetry
    end
  end
end
