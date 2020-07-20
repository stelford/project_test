defmodule TestAppWeb.RushingStatisticsLive do
  use Phoenix.LiveView, layout: {TestAppWeb.LayoutView, "live.html"}

  import Ecto.Query
  alias TestApp.Football.Player.RushingStatistic, as: RushingStatistic

  def mount(_params, _session, socket) do
    {:ok, assign(socket, statistics: nil, order_by: nil)}
  end

  def render(assigns) do
    ~L"""
    <h1>LiveView is alive</h1>
    <table>
      <thead>
        <th>
          Name
        </th>
      </thead>
      <tbody>
        <%= for stat <- statistics(assigns) do %>
          <tr>
            <td><%= stat.player_name %></td>
          </tr>
        <% end %>
      </tbody>
    </table>
    """
  end


  defp statistics(%{statistics: nil, order_by: nil}) do
    from(a in RushingStatistic,
         order_by: a.player_name)
    |> TestApp.Repo.all()
  end

end
