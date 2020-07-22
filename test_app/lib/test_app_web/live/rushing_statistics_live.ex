defmodule TestAppWeb.RushingStatisticsLive do
  use Phoenix.LiveView, layout: {TestAppWeb.LayoutView, "live.html"}
  import Phoenix.HTML.Link, only: [button: 2]

  import Ecto.Query
  alias TestApp.Football.Player.RushingStatistic, as: RushingStatistic

  def mount(_params, _session, socket) do
    {:ok, assign(socket, order_by: :player_name, asc_or_desc: :asc, current_page: 1, page_size: 25)}
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
        <th phx-click="order-by" phx-value-order_by="player_name" phx-value-asc_or_desc="<%= assigns.asc_or_desc %>" class="<%= if assigns.order_by == :player_name do 'column-active'; else ''; end %>">
          Name <%= if assigns.order_by == :player_name do assigns.asc_or_desc; else ''; end %>
        </th>
        <th phx-click="order-by" phx-value-order_by="team" phx-value-asc_or_desc="<%= assigns.asc_or_desc %>" class="<%= if assigns.order_by == :team do 'column-active'; else ''; end %>">
          Team <%= if assigns.order_by == :team do assigns.asc_or_desc; else ''; end %>
        </th>
        <th phx-click="order-by" phx-value-order_by="player_position" phx-value-asc_or_desc="<%= assigns.asc_or_desc %>" class="<%= if assigns.order_by == :player_position do 'column-active'; else ''; end %>">
          Position <%= if assigns.order_by == :player_position do assigns.asc_or_desc; else ''; end %>
        </th>
        <th phx-click="order-by" phx-value-order_by="attempts" phx-value-asc_or_desc="<%= assigns.asc_or_desc %>" class="<%= if assigns.order_by == :attempts do 'column-active'; else ''; end %>">
          Attempts <%= if assigns.order_by == :attempts do assigns.asc_or_desc; else ''; end %>
        </th>
        <th phx-click="order-by" phx-value-order_by="attempts_per_game" phx-value-asc_or_desc="<%= assigns.asc_or_desc %>" class="<%= if assigns.order_by == :attempts_per_game do 'column-active'; else ''; end %>">
          Attempts Per Game <%= if assigns.order_by == :attempts_per_game do assigns.asc_or_desc; else ''; end %>
        </th>
        <th phx-click="order-by" phx-value-order_by="yards_per_game" phx-value-asc_or_desc="<%= assigns.asc_or_desc %>" class="<%= if assigns.order_by == :yards_per_game do 'column-active'; else ''; end %>">
          Yards Per Game <%= if assigns.order_by == :yards_per_game do assigns.asc_or_desc; else ''; end %>
        </th>
        <th phx-click="order-by" phx-value-order_by="average_yards" phx-value-asc_or_desc="<%= assigns.asc_or_desc %>" class="<%= if assigns.order_by == :average_yards do 'column-active'; else ''; end %>">
          Average Yards <%= if assigns.order_by == :average_yards do assigns.asc_or_desc; else ''; end %>
        </th>
        <th phx-click="order-by" phx-value-order_by="total_yards" phx-value-asc_or_desc="<%= assigns.asc_or_desc %>" class="<%= if assigns.order_by == :total_yards do 'column-active'; else ''; end %>">
          Total Yards <%= if assigns.order_by == :total_yards do assigns.asc_or_desc; else ''; end %>
        </th>
        <th phx-click="order-by" phx-value-order_by="touchdowns" phx-value-asc_or_desc="<%= assigns.asc_or_desc %>" class="<%= if assigns.order_by == :touchdowns do 'column-active'; else ''; end %>">
          Touchdowns <%= if assigns.order_by == :touchdowns do assigns.asc_or_desc; else ''; end %>
        </th>
        <th phx-click="order-by" phx-value-order_by="longest_rush" phx-value-asc_or_desc="<%= assigns.asc_or_desc %>" class="<%= if assigns.order_by == :longest_rush do 'column-active'; else ''; end %>">
          Longest Rush <%= if assigns.order_by == :longest_rush do assigns.asc_or_desc; else ''; end %>
        </th>
        <th phx-click="order-by" phx-value-order_by="first_downs" phx-value-asc_or_desc="<%= assigns.asc_or_desc %>" class="<%= if assigns.order_by == :first_downs do 'column-active'; else ''; end %>">
          First Downs <%= if assigns.order_by == :first_downs do assigns.asc_or_desc; else ''; end %>
        </th>
        <th phx-click="order-by" phx-value-order_by="first_downs_pct" phx-value-asc_or_desc="<%= assigns.asc_or_desc %>" class="<%= if assigns.order_by == :first_downs_pct do 'column-active'; else ''; end %>">
          First Downs Pct <%= if assigns.order_by == :first_downs_pct do assigns.asc_or_desc; else ''; end %>
        </th>
        <th phx-click="order-by" phx-value-order_by="twenty_yards_plus" phx-value-asc_or_desc="<%= assigns.asc_or_desc %>" class="<%= if assigns.order_by == :twenty_yards_plus do 'column-active'; else ''; end %>">
          Twenty Yards Plus <%= if assigns.order_by == :twenty_yards_plus do assigns.asc_or_desc; else ''; end %>
        </th>
        <th phx-click="order-by" phx-value-order_by="fourty_yards_plus" phx-value-asc_or_desc="<%= assigns.asc_or_desc %>" class="<%= if assigns.order_by == :fourty_yards_plus do 'column-active'; else ''; end %>">
          Fourty Yards Plus <%= if assigns.order_by == :fourty_yards_plus do assigns.asc_or_desc; else ''; end %>
        </th>
        <th phx-click="order-by" phx-value-order_by="fumbles" phx-value-asc_or_desc="<%= assigns.asc_or_desc %>" class="<%= if assigns.order_by == :fumbles do 'column-active'; else ''; end %>">
          Fumbles <%= if assigns.order_by == :fumbles do assigns.asc_or_desc; else ''; end %>
        </th>
      </thead>
      <tbody>
        <%= for stat <- statistics(assigns) do %>
          <tr>
            <td><%= stat.player_name %></td>
            <td><%= stat.team %></td>
            <td><%= stat.player_position %></td>
            <td><%= stat.attempts %></td>
            <td><%= stat.attempts_per_game %></td>
            <td><%= stat.yards_per_game %></td>
            <td><%= stat.average_yards %></td>
            <td><%= stat.total_yards %></td>
            <td><%= stat.touchdowns %></td>
            <td><%= stat.longest_rush %></td>
            <td><%= stat.first_downs %></td>
            <td><%= stat.first_downs_pct %></td>
            <td><%= stat.twenty_yards_plus %></td>
            <td><%= stat.fourty_yards_plus %></td>
            <td><%= stat.fumbles %></td>
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

  def handle_event("order-by", %{"asc_or_desc" => "asc", "order_by" => order_by}, socket) do
    IO.inspect(socket)
    {:noreply, assign(socket, %{order_by: String.to_atom(order_by), asc_or_desc: :desc})}
  end

  def handle_event("order-by", %{"asc_or_desc" => "desc", "order_by" => order_by}, socket) do
    {:noreply, assign(socket, %{order_by: String.to_atom(order_by), asc_or_desc: :asc})}
  end

  defp statistics(%{order_by: order_by, asc_or_desc: :asc, current_page: current_page, page_size: page_size}) do
    from(a in RushingStatistic,
      order_by: [asc: ^order_by],
      offset: ^((current_page-1)*page_size),
      limit: ^page_size
    )
    |> TestApp.Repo.all()
  end

  defp statistics(%{order_by: order_by, asc_or_desc: :desc, current_page: current_page, page_size: page_size}) do
    from(a in RushingStatistic,
      order_by: [desc: ^order_by],
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
