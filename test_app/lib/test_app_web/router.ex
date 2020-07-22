defmodule TestAppWeb.Router do
  use TestAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_root_layout, {TestAppWeb.LayoutView, :root}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TestAppWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/report/rushing_statistic", ReportController, :rushing_statistic_to_csv
    live "/mylive", RushingStatisticsLive
    resources "/rushing_statistic", RushingStatisticController
  end

  # Other scopes may use custom stacks.
  # scope "/api", TestAppWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: TestAppWeb.Telemetry
    end
  end
end
