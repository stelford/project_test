defmodule TestAppWeb.RushingStatisticControllerTest do
  use TestAppWeb.ConnCase

  alias TestApp.Football.Player

  @create_attrs %{attempts: 120.5, attempts_per_game: 120.5, average_yards: 120.5, first_downs: 42, first_downs_pct: 120.5, fourty_yards_plus: 42, fumbles: 42, longest_rush: 80, player_name: "some player_name", player_position: "some player_position", team: "some team", total_yards: 120.5, touchdowns: 42, twenty_yards_plus: 42, yards_per_game: 120.5}
  @update_attrs %{attempts: 456.7, attempts_per_game: 456.7, average_yards: 456.7, first_downs: 43, first_downs_pct: 456.7, fourty_yards_plus: 43, fumbles: 43, longest_rush: 81, player_name: "some updated player_name", player_position: "some updated player_position", team: "some updated team", total_yards: 456.7, touchdowns: 43, twenty_yards_plus: 43, yards_per_game: 456.7}
  @invalid_attrs %{attempts: nil, attempts_per_game: nil, average_yards: nil, first_downs: nil, first_downs_pct: nil, fourty_yards_plus: nil, fumbles: nil, longest_rush: nil, player_name: nil, player_position: nil, team: nil, total_yards: nil, touchdowns: nil, twenty_yards_plus: nil, yards_per_game: nil}

  def fixture(:rushing_statistic) do
    {:ok, rushing_statistic} = Player.create_rushing_statistic(@create_attrs)
    rushing_statistic
  end

  describe "index" do
    test "lists all rushing_statistics", %{conn: conn} do
      conn = get(conn, Routes.rushing_statistic_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Rushing statistics"
    end
  end

  describe "new rushing_statistic" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.rushing_statistic_path(conn, :new))
      assert html_response(conn, 200) =~ "New Rushing statistic"
    end
  end

  describe "create rushing_statistic" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.rushing_statistic_path(conn, :create), rushing_statistic: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.rushing_statistic_path(conn, :show, id)

      conn = get(conn, Routes.rushing_statistic_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Rushing statistic"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.rushing_statistic_path(conn, :create), rushing_statistic: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Rushing statistic"
    end
  end

  describe "edit rushing_statistic" do
    setup [:create_rushing_statistic]

    test "renders form for editing chosen rushing_statistic", %{conn: conn, rushing_statistic: rushing_statistic} do
      conn = get(conn, Routes.rushing_statistic_path(conn, :edit, rushing_statistic))
      assert html_response(conn, 200) =~ "Edit Rushing statistic"
    end
  end

  describe "update rushing_statistic" do
    setup [:create_rushing_statistic]

    test "redirects when data is valid", %{conn: conn, rushing_statistic: rushing_statistic} do
      conn = put(conn, Routes.rushing_statistic_path(conn, :update, rushing_statistic), rushing_statistic: @update_attrs)
      assert redirected_to(conn) == Routes.rushing_statistic_path(conn, :show, rushing_statistic)

      conn = get(conn, Routes.rushing_statistic_path(conn, :show, rushing_statistic))
      assert html_response(conn, 200) =~ "some updated "
    end

    test "renders errors when data is invalid", %{conn: conn, rushing_statistic: rushing_statistic} do
      conn = put(conn, Routes.rushing_statistic_path(conn, :update, rushing_statistic), rushing_statistic: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Rushing statistic"
    end
  end

  describe "delete rushing_statistic" do
    setup [:create_rushing_statistic]

    test "deletes chosen rushing_statistic", %{conn: conn, rushing_statistic: rushing_statistic} do
      conn = delete(conn, Routes.rushing_statistic_path(conn, :delete, rushing_statistic))
      assert redirected_to(conn) == Routes.rushing_statistic_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.rushing_statistic_path(conn, :show, rushing_statistic))
      end
    end
  end

  defp create_rushing_statistic(_) do
    rushing_statistic = fixture(:rushing_statistic)
    %{rushing_statistic: rushing_statistic}
  end
end
