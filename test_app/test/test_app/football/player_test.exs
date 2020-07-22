defmodule TestApp.Football.PlayerTest do
  use TestApp.DataCase

  alias TestApp.Football.Player

  describe "rushing_statistics" do
    alias TestApp.Football.Player.RushingStatistic

    @valid_attrs %{attempts: 120.5, attempts_per_game: 120.5, average_yards: 120.5, first_downs: 42, first_downs_pct: 120.5, fourty_yards_plus: 42, fumbles: 42, longest_rush: 80, player_name: "some player_name", player_position: "some player_position", team: "some team", total_yards: 120.5, touchdowns: 42, twenty_yards_plus: 42, yards_per_game: 120.5}
    @update_attrs %{attempts: 456.7, attempts_per_game: 456.7, average_yards: 456.7, first_downs: 43, first_downs_pct: 456.7, fourty_yards_plus: 43, fumbles: 43, longest_rush: 81, player_name: "some updated player_name", player_position: "some updated player_position", team: "some updated team", total_yards: 456.7, touchdowns: 43, twenty_yards_plus: 43, yards_per_game: 456.7}
    @invalid_attrs %{attempts: nil, attempts_per_game: nil, average_yards: nil, first_downs: nil, first_downs_pct: nil, fourty_yards_plus: nil, fumbles: nil, longest_rush: nil, player_name: nil, player_position: nil, team: nil, total_yards: nil, touchdowns: nil, twenty_yards_plus: nil, yards_per_game: nil}

    def rushing_statistic_fixture(attrs \\ %{}) do
      {:ok, rushing_statistic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Player.create_rushing_statistic()

      rushing_statistic
    end

    test "list_rushing_statistics/0 returns all rushing_statistics" do
      rushing_statistic = rushing_statistic_fixture()
      assert Player.list_rushing_statistics() == [rushing_statistic]
    end

    test "get_rushing_statistic!/1 returns the rushing_statistic with given id" do
      rushing_statistic = rushing_statistic_fixture()
      assert Player.get_rushing_statistic!(rushing_statistic.id) == rushing_statistic
    end

    test "create_rushing_statistic/1 with valid data creates a rushing_statistic" do
      assert {:ok, %RushingStatistic{} = rushing_statistic} = Player.create_rushing_statistic(@valid_attrs)
      assert rushing_statistic.attempts == 120.5
      assert rushing_statistic.attempts_per_game == 120.5
      assert rushing_statistic.average_yards == 120.5
      assert rushing_statistic.first_downs == 42
      assert rushing_statistic.first_downs_pct == 120.5
      assert rushing_statistic.fourty_yards_plus == 42
      assert rushing_statistic.fumbles == 42
      assert rushing_statistic.longest_rush == 80
      assert rushing_statistic.player_name == "some player_name"
      assert rushing_statistic.player_position == "some player_position"
      assert rushing_statistic.team == "some team"
      assert rushing_statistic.total_yards == 120.5
      assert rushing_statistic.touchdowns == 42
      assert rushing_statistic.twenty_yards_plus == 42
      assert rushing_statistic.yards_per_game == 120.5
    end

    test "create_rushing_statistic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Player.create_rushing_statistic(@invalid_attrs)
    end

    test "update_rushing_statistic/2 with valid data updates the rushing_statistic" do
      rushing_statistic = rushing_statistic_fixture()
      assert {:ok, %RushingStatistic{} = rushing_statistic} = Player.update_rushing_statistic(rushing_statistic, @update_attrs)
      assert rushing_statistic.attempts == 456.7
      assert rushing_statistic.attempts_per_game == 456.7
      assert rushing_statistic.average_yards == 456.7
      assert rushing_statistic.first_downs == 43
      assert rushing_statistic.first_downs_pct == 456.7
      assert rushing_statistic.fourty_yards_plus == 43
      assert rushing_statistic.fumbles == 43
      assert rushing_statistic.longest_rush == 81
      assert rushing_statistic.player_name == "some updated player_name"
      assert rushing_statistic.player_position == "some updated player_position"
      assert rushing_statistic.team == "some updated team"
      assert rushing_statistic.total_yards == 456.7
      assert rushing_statistic.touchdowns == 43
      assert rushing_statistic.twenty_yards_plus == 43
      assert rushing_statistic.yards_per_game == 456.7
    end

    test "update_rushing_statistic/2 with invalid data returns error changeset" do
      rushing_statistic = rushing_statistic_fixture()
      assert {:error, %Ecto.Changeset{}} = Player.update_rushing_statistic(rushing_statistic, @invalid_attrs)
      assert rushing_statistic == Player.get_rushing_statistic!(rushing_statistic.id)
    end

    test "delete_rushing_statistic/1 deletes the rushing_statistic" do
      rushing_statistic = rushing_statistic_fixture()
      assert {:ok, %RushingStatistic{}} = Player.delete_rushing_statistic(rushing_statistic)
      assert_raise Ecto.NoResultsError, fn -> Player.get_rushing_statistic!(rushing_statistic.id) end
    end

    test "change_rushing_statistic/1 returns a rushing_statistic changeset" do
      rushing_statistic = rushing_statistic_fixture()
      assert %Ecto.Changeset{} = Player.change_rushing_statistic(rushing_statistic)
    end
  end
end
