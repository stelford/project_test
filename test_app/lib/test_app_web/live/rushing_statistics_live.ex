defmodule TestAppWeb.RushingStatisticsLive do
  use Phoenix.LiveView, layout: {TestAppWeb.LayoutView, "live.html"}
  import Phoenix.HTML.Link, only: [button: 2]

  import Ecto.Query
  alias TestApp.Football.Player.RushingStatistic, as: RushingStatistic

  def mount(_params, _session, socket) do
    {:ok, assign(socket, statistics: nil, order_by: :player_name, current_page: 1, page_size: 25)}
  end

  def render(assigns) do
    ~L"""
    <% all_pages = number_of_pages(assigns) %>

    <div class="float-left">
      <form phx-change="select-page">
        Page
        <select name="page">
          <%= for page <- all_pages do %>
            <option value="<%= page %>" <%= page == assigns.current_page && "selected" || "" %>>
              <%= page %>
            </option>
          <% end %>
        </select>
      </form>
    </div>

    <div class="float-right">
      <%= button("Export to CSV", to: ("/report/rushing_statistic?filter_player_name=" <> assigns.filter_player_name <> "&order_by=" <> Atom.to_string(assigns.order_by) <> "&asc_or_desc=" <> Atom.to_string(assigns.asc_or_desc)), data: [hello: "there"], target: "_blank", method: :post) %>
    </div>

    <table>
      <thead>
        <th phx-click="order-by" phx-value-order_by="player_name">
          Name
        </th>
        <th phx-click="order-by" phx-value-order_by="team">
          Team
        </th>
      </thead>
      <tbody>
        <%= for stat <- statistics(assigns) do %>
          <tr>
            <td><%= stat.player_name %></td>
            <td><%= stat.team %></td>
          </tr>
        <% end %>
      </tbody>
    </table>

    <form phx-change="select-page">
      Page
      <select name="page">
        <%= for page <- all_pages do %>
          <option value="<%= page %>" <%= page == assigns.current_page && "selected" || "" %>>
            <%= page %>
          </option>
        <% end %>
      </select>
    </form>
    """
  end

  def handle_event("select-page", %{"page" => page}, socket) do
    {:noreply, assign(socket, current_page: String.to_integer(page))}
  end

  def handle_event("order-by", %{"order_by" => order_by}, socket) do
    {:noreply, assign(socket, order_by: String.to_atom(order_by))}
  end

  defp statistics(%{statistics: nil, order_by: order_by, current_page: current_page, page_size: page_size}) do
    IO.puts(order_by)
    from(a in RushingStatistic,
      order_by: ^order_by,
      offset: ^((current_page-1)*page_size),
      limit: ^page_size
    )
    |> TestApp.Repo.all()
  end

  defp number_of_pages(%{page_size: page_size}) do
    count_result = from(a in RushingStatistic, select: count(a.id))
                   |> TestApp.Repo.one()
    count_result = trunc(Float.ceil(count_result / page_size))
    Enum.to_list(1..count_result)
  end

end
