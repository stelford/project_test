defmodule TestAppWeb.RushingStatisticsLive do
  use Phoenix.LiveView, layout: {TestAppWeb.LayoutView, "live.html"}

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>LiveView is awesome!</h1>
    """
  end
end
